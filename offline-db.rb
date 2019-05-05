require "sqlite3"

@db = SQLite3::Database.new "offline-us.db"
rows = @db.execute <<-SQL
  create table IF NOT EXISTS callsigns (
    name varchar(30),
    address varchar(45),
    city varchar(30),
    state varchar(2),
    zipcode int,
    callsign varchar(8)
  );
SQL

@lines = []
File.readlines('/home/bmartin/Documents/EN.dat').each { | line | @lines << line }
FILE_RECORD_COUNT = @lines.size

def setup(thread_count)
  threads = []
  fetches_per_thread = FILE_RECORD_COUNT / thread_count
  raise 'invalid slice size' if fetches_per_thread < 1
  @db.transaction
  @lines.each_slice(fetches_per_thread) do | slice |
    threads << Thread.new do
      slice.each do | line |
        db_line = line.split('|')
        callsign =  db_line[4]
        name = db_line[7]
        address = db_line[15]
        city = db_line[16]
        state = db_line[17]
        zipcode = db_line[18]
        @db.execute("INSERT INTO callsigns (callsign, name, address, city, state, zipcode) VALUES (?, ?, ?, ?, ?, ?)", [callsign, name, address, city, state, zipcode])
      end # slice.each
    end # Thread.new
  end # @lines.each_slice
  threads.each(&:join)
  @db.commit
end # def setup
setup(1)

#File.readlines('/home/bmartin/Documents/EN.dat').each do |line|
#  db_line = line.split('|')
#  callsign =  db_line[4]
#  name = db_line[7]
#  address = db_line[15]
#  city = db_line[16]
#  state = db_line[17]
#  zipcode = db_line[18]
#  db.execute("INSERT INTO callsigns (callsign, name, address, city, state, zipcode) VALUES (?, ?, ?, ?, ?, ?)", [callsign, name, address, city, state, zipcode])
#end

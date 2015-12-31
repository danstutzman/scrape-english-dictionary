#first_link2spanish = {}
#Dir.glob('dictionary/indexSpa*.csv') do |path|
#  File.open(path).each_line do |line|
#    spanish, links = line.strip.split("\t")
#    spanish.split(' ').each do |spanish_word|
#      first_link = links.split(',')[0].gsub(/S$/, 'B')
#      first_link2spanish[first_link] ||= []
#      first_link2spanish[first_link].push spanish_word
#    end
#  end
#end

puts "DROP TABLE IF EXISTS translations;"
puts "CREATE TABLE translations (
  spanish TEXT NOT NULL,
  english TEXT NOT NULL
);
COPY translations FROM STDIN WITH CSV HEADER;
spanish,english"

#Dir.glob('dictionary/indexEng*.csv') do |path|
#  File.open(path).each_line do |line|
#    english, links = line.strip.split("\t")
#    links.split(',').each do |link|
#      (first_link2spanish[link] || []).each do |spanish|
#        puts "#{spanish},#{english}"
#      end
#    end
#  end
#end
File.read('downloaded.txt').split("\n").each do |line|
  englishes, spanishes = line.strip.split("\t")
  next if line.strip == 'english,spanish'
  next if line.start_with?('#')
  next if englishes.include?('"')
  raise line if spanishes.nil?
  englishes.split(' ; ').each do |english|
    spanishes.split(' ; ').each do |spanish|
      puts "\"#{spanish}\",\"#{english}\""
    end
  end
end

puts "\\."

#puts 'ALTER TABLE translations ADD COLUMN word_id INT;'
#puts 'UPDATE translations SET word_id = words.word_id
#  FROM words WHERE words.word = translations.spanish;'
puts 'ALTER TABLE words ADD COLUMN english_translation TEXT;'
puts 'UPDATE words SET english_translation = translations.english
  FROM translations WHERE translations.spanish = words.lemma;'


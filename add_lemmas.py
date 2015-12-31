import codecs
import pattern.es

print "DROP TABLE IF EXISTS word_lemmas;"
print """CREATE TABLE word_lemmas (
  base_word TEXT NOT NULL,
  lemma     TEXT NOT NULL
);
COPY word_lemmas FROM STDIN WITH CSV HEADER;
base_word,lemma"""

with codecs.open('words.txt', 'r', 'utf-8') as infile:
  for line in infile:
    sentences = pattern.es.parsetree(line, lemmata=True)
    for sentence in sentences:
      for word in sentence:
        print ('%s,%s' % (line.strip(), word.lemma)).encode('utf-8')

print '\\.'

print "ALTER TABLE words ADD COLUMN lemma TEXT;"
print """UPDATE words SET lemma = word_lemmas.lemma
  FROM word_lemmas WHERE word_lemmas.base_word = words.word;"""

use v6;
use DateTime::TimeZone::Zone;
class DateTime::TimeZone::Zone::Europe::Luxembourg does DateTime::TimeZone::Zone;
has %.rules = ( 
 Belgium => [{"time" => "0:00s", "letter" => "S", "adjust" => "1:00", "month" => 3, "years" => 1918..1918, "date" => "9"}, {"time" => "23:00s", "letter" => "-", "adjust" => "0", "month" => 10, "dow" => {"mindate" => "1", "dow" => 6}, "years" => 1918..1919}, {"time" => "23:00s", "letter" => "S", "adjust" => "1:00", "month" => 3, "years" => 1919..1919, "date" => "1"}, {"time" => "23:00s", "letter" => "S", "adjust" => "1:00", "month" => 2, "years" => 1920..1920, "date" => "14"}, {"time" => "23:00s", "letter" => "-", "adjust" => "0", "month" => 10, "years" => 1920..1920, "date" => "23"}, {"time" => "23:00s", "letter" => "S", "adjust" => "1:00", "month" => 3, "years" => 1921..1921, "date" => "14"}, {"time" => "23:00s", "letter" => "-", "adjust" => "0", "month" => 10, "years" => 1921..1921, "date" => "25"}, {"time" => "23:00s", "letter" => "S", "adjust" => "1:00", "month" => 3, "years" => 1922..1922, "date" => "25"}, {"time" => "23:00s", "letter" => "-", "adjust" => "0", "month" => 10, "dow" => {"mindate" => "1", "dow" => 6}, "years" => 1922..1927}, {"time" => "23:00s", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1923..1923, "date" => "21"}, {"time" => "23:00s", "letter" => "S", "adjust" => "1:00", "month" => 3, "years" => 1924..1924, "date" => "29"}, {"time" => "23:00s", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1925..1925, "date" => "4"}, {"time" => "23:00s", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1926..1926, "date" => "17"}, {"time" => "23:00s", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1927..1927, "date" => "9"}, {"time" => "23:00s", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1928..1928, "date" => "14"}, {"time" => "2:00s", "letter" => "-", "adjust" => "0", "month" => 10, "dow" => {"mindate" => "2", "dow" => 7}, "years" => 1928..1938}, {"time" => "2:00s", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1929..1929, "date" => "21"}, {"time" => "2:00s", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1930..1930, "date" => "13"}, {"time" => "2:00s", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1931..1931, "date" => "19"}, {"time" => "2:00s", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1932..1932, "date" => "3"}, {"time" => "2:00s", "letter" => "S", "adjust" => "1:00", "month" => 3, "years" => 1933..1933, "date" => "26"}, {"time" => "2:00s", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1934..1934, "date" => "8"}, {"time" => "2:00s", "letter" => "S", "adjust" => "1:00", "month" => 3, "years" => 1935..1935, "date" => "31"}, {"time" => "2:00s", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1936..1936, "date" => "19"}, {"time" => "2:00s", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1937..1937, "date" => "4"}, {"time" => "2:00s", "letter" => "S", "adjust" => "1:00", "month" => 3, "years" => 1938..1938, "date" => "27"}, {"time" => "2:00s", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1939..1939, "date" => "16"}, {"time" => "2:00s", "letter" => "-", "adjust" => "0", "month" => 11, "years" => 1939..1939, "date" => "19"}, {"time" => "2:00s", "letter" => "S", "adjust" => "1:00", "month" => 2, "years" => 1940..1940, "date" => "25"}, {"time" => "2:00s", "letter" => "-", "adjust" => "0", "month" => 9, "years" => 1944..1944, "date" => "17"}, {"time" => "2:00s", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1945..1945, "date" => "2"}, {"time" => "2:00s", "letter" => "-", "adjust" => "0", "month" => 9, "years" => 1945..1945, "date" => "16"}, {"time" => "2:00s", "letter" => "S", "adjust" => "1:00", "month" => 5, "years" => 1946..1946, "date" => "19"}, {"time" => "2:00s", "letter" => "-", "adjust" => "0", "month" => 10, "years" => 1946..1946, "date" => "7"}],
 C-Eur => [{"time" => "23:00", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1916..1916, "date" => "30"}, {"time" => "1:00", "letter" => "-", "adjust" => "0", "month" => 10, "years" => 1916..1916, "date" => "1"}, {"time" => "2:00s", "letter" => "S", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "15", "dow" => 1}, "years" => 1917..1918}, {"time" => "2:00s", "letter" => "-", "adjust" => "0", "month" => 9, "dow" => {"mindate" => "15", "dow" => 1}, "years" => 1917..1918}, {"time" => "2:00s", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1940..1940, "date" => "1"}, {"time" => "2:00s", "letter" => "-", "adjust" => "0", "month" => 11, "years" => 1942..1942, "date" => "2"}, {"time" => "2:00s", "letter" => "S", "adjust" => "1:00", "month" => 3, "years" => 1943..1943, "date" => "29"}, {"time" => "2:00s", "letter" => "-", "adjust" => "0", "month" => 10, "years" => 1943..1943, "date" => "4"}, {"time" => "2:00s", "letter" => "S", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "1", "dow" => 1}, "years" => 1944..1945}, {"time" => "2:00s", "letter" => "-", "adjust" => "0", "month" => 10, "years" => 1944..1944, "date" => "2"}, {"time" => "2:00s", "letter" => "-", "adjust" => "0", "month" => 9, "years" => 1945..1945, "date" => "16"}, {"time" => "2:00s", "letter" => "S", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "1", "dow" => 7}, "years" => 1977..1980}, {"time" => "2:00s", "lastdow" => 7, "letter" => "-", "adjust" => "0", "month" => 9, "years" => 1977..1977}, {"time" => "2:00s", "letter" => "-", "adjust" => "0", "month" => 10, "years" => 1978..1978, "date" => "1"}, {"time" => "2:00s", "lastdow" => 7, "letter" => "-", "adjust" => "0", "month" => 9, "years" => 1979..1995}, {"time" => "2:00s", "lastdow" => 7, "letter" => "S", "adjust" => "1:00", "month" => 3, "years" => 1981..Inf}, {"time" => "2:00s", "lastdow" => 7, "letter" => "-", "adjust" => "0", "month" => 10, "years" => 1996..Inf}],
 EU => [{"time" => "1:00u", "letter" => "S", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "1", "dow" => 7}, "years" => 1977..1980}, {"time" => "1:00u", "lastdow" => 7, "letter" => "-", "adjust" => "0", "month" => 9, "years" => 1977..1977}, {"time" => "1:00u", "letter" => "-", "adjust" => "0", "month" => 10, "years" => 1978..1978, "date" => "1"}, {"time" => "1:00u", "lastdow" => 7, "letter" => "-", "adjust" => "0", "month" => 9, "years" => 1979..1995}, {"time" => "1:00u", "lastdow" => 7, "letter" => "S", "adjust" => "1:00", "month" => 3, "years" => 1981..Inf}, {"time" => "1:00u", "lastdow" => 7, "letter" => "-", "adjust" => "0", "month" => 10, "years" => 1996..Inf}],
 Lux => [{"time" => "23:00", "letter" => "S", "adjust" => "1:00", "month" => 5, "years" => 1916..1916, "date" => "14"}, {"time" => "1:00", "letter" => "-", "adjust" => "0", "month" => 10, "years" => 1916..1916, "date" => "1"}, {"time" => "23:00", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1917..1917, "date" => "28"}, {"time" => "1:00", "letter" => "-", "adjust" => "0", "month" => 9, "years" => 1917..1917, "date" => "17"}, {"time" => "2:00s", "letter" => "S", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "15", "dow" => 1}, "years" => 1918..1918}, {"time" => "2:00s", "letter" => "-", "adjust" => "0", "month" => 9, "dow" => {"mindate" => "15", "dow" => 1}, "years" => 1918..1918}, {"time" => "23:00", "letter" => "S", "adjust" => "1:00", "month" => 3, "years" => 1919..1919, "date" => "1"}, {"time" => "3:00", "letter" => "-", "adjust" => "0", "month" => 10, "years" => 1919..1919, "date" => "5"}, {"time" => "23:00", "letter" => "S", "adjust" => "1:00", "month" => 2, "years" => 1920..1920, "date" => "14"}, {"time" => "2:00", "letter" => "-", "adjust" => "0", "month" => 10, "years" => 1920..1920, "date" => "24"}, {"time" => "23:00", "letter" => "S", "adjust" => "1:00", "month" => 3, "years" => 1921..1921, "date" => "14"}, {"time" => "2:00", "letter" => "-", "adjust" => "0", "month" => 10, "years" => 1921..1921, "date" => "26"}, {"time" => "23:00", "letter" => "S", "adjust" => "1:00", "month" => 3, "years" => 1922..1922, "date" => "25"}, {"time" => "1:00", "letter" => "-", "adjust" => "0", "month" => 10, "dow" => {"mindate" => "2", "dow" => 7}, "years" => 1922..1922}, {"time" => "23:00", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1923..1923, "date" => "21"}, {"time" => "2:00", "letter" => "-", "adjust" => "0", "month" => 10, "dow" => {"mindate" => "2", "dow" => 7}, "years" => 1923..1923}, {"time" => "23:00", "letter" => "S", "adjust" => "1:00", "month" => 3, "years" => 1924..1924, "date" => "29"}, {"time" => "1:00", "letter" => "-", "adjust" => "0", "month" => 10, "dow" => {"mindate" => "2", "dow" => 7}, "years" => 1924..1928}, {"time" => "23:00", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1925..1925, "date" => "5"}, {"time" => "23:00", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1926..1926, "date" => "17"}, {"time" => "23:00", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1927..1927, "date" => "9"}, {"time" => "23:00", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1928..1928, "date" => "14"}, {"time" => "23:00", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1929..1929, "date" => "20"}],
);
has @.zonedata = Array.new({"baseoffset" => "0:24:36", "rules" => "", "until" => -2082844800}, {"baseoffset" => "1:00", "rules" => "Lux", "until" => -1612656000}, {"baseoffset" => "0:00", "rules" => "Lux", "until" => -1269813600}, {"baseoffset" => "0:00", "rules" => "Belgium", "until" => -935182800}, {"baseoffset" => "1:00", "rules" => "C-Eur", "until" => -797979600}, {"baseoffset" => "1:00", "rules" => "Belgium", "until" => 220924800}, {"baseoffset" => "1:00", "rules" => "EU", "until" => Inf});

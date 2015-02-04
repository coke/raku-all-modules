use v6;
use DateTime::TimeZone::Zone;
class DateTime::TimeZone::Zone::Europe::Dublin does DateTime::TimeZone::Zone;
has %.rules = ( 
 EU => [{"time" => "1:00u", "letter" => "S", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "1", "dow" => 7}, "years" => 1977..1980}, {"time" => "1:00u", "lastdow" => 7, "letter" => "-", "adjust" => "0", "month" => 9, "years" => 1977..1977}, {"time" => "1:00u", "letter" => "-", "adjust" => "0", "month" => 10, "years" => 1978..1978, "date" => "1"}, {"time" => "1:00u", "lastdow" => 7, "letter" => "-", "adjust" => "0", "month" => 9, "years" => 1979..1995}, {"time" => "1:00u", "lastdow" => 7, "letter" => "S", "adjust" => "1:00", "month" => 3, "years" => 1981..Inf}, {"time" => "1:00u", "lastdow" => 7, "letter" => "-", "adjust" => "0", "month" => 10, "years" => 1996..Inf}],
 GB-Eire => [{"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 5, "years" => 1916..1916, "date" => "21"}, {"time" => "2:00s", "letter" => "GMT", "adjust" => "0", "month" => 10, "years" => 1916..1916, "date" => "1"}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "years" => 1917..1917, "date" => "8"}, {"time" => "2:00s", "letter" => "GMT", "adjust" => "0", "month" => 9, "years" => 1917..1917, "date" => "17"}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 3, "years" => 1918..1918, "date" => "24"}, {"time" => "2:00s", "letter" => "GMT", "adjust" => "0", "month" => 9, "years" => 1918..1918, "date" => "30"}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 3, "years" => 1919..1919, "date" => "30"}, {"time" => "2:00s", "letter" => "GMT", "adjust" => "0", "month" => 9, "years" => 1919..1919, "date" => "29"}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 3, "years" => 1920..1920, "date" => "28"}, {"time" => "2:00s", "letter" => "GMT", "adjust" => "0", "month" => 10, "years" => 1920..1920, "date" => "25"}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "years" => 1921..1921, "date" => "3"}, {"time" => "2:00s", "letter" => "GMT", "adjust" => "0", "month" => 10, "years" => 1921..1921, "date" => "3"}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 3, "years" => 1922..1922, "date" => "26"}, {"time" => "2:00s", "letter" => "GMT", "adjust" => "0", "month" => 10, "years" => 1922..1922, "date" => "8"}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "16", "dow" => 7}, "years" => 1923..1923}, {"time" => "2:00s", "letter" => "GMT", "adjust" => "0", "month" => 9, "dow" => {"mindate" => "16", "dow" => 7}, "years" => 1923..1924}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "9", "dow" => 7}, "years" => 1924..1924}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "16", "dow" => 7}, "years" => 1925..1926}, {"time" => "2:00s", "letter" => "GMT", "adjust" => "0", "month" => 10, "dow" => {"mindate" => "2", "dow" => 7}, "years" => 1925..1938}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "9", "dow" => 7}, "years" => 1927..1927}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "16", "dow" => 7}, "years" => 1928..1929}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "9", "dow" => 7}, "years" => 1930..1930}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "16", "dow" => 7}, "years" => 1931..1932}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "9", "dow" => 7}, "years" => 1933..1933}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "16", "dow" => 7}, "years" => 1934..1934}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "9", "dow" => 7}, "years" => 1935..1935}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "16", "dow" => 7}, "years" => 1936..1937}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "9", "dow" => 7}, "years" => 1938..1938}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "16", "dow" => 7}, "years" => 1939..1939}, {"time" => "2:00s", "letter" => "GMT", "adjust" => "0", "month" => 11, "dow" => {"mindate" => "16", "dow" => 7}, "years" => 1939..1939}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 2, "dow" => {"mindate" => "23", "dow" => 7}, "years" => 1940..1940}, {"time" => "1:00s", "letter" => "BDST", "adjust" => "2:00", "month" => 5, "dow" => {"mindate" => "2", "dow" => 7}, "years" => 1941..1941}, {"time" => "1:00s", "letter" => "BST", "adjust" => "1:00", "month" => 8, "dow" => {"mindate" => "9", "dow" => 7}, "years" => 1941..1943}, {"time" => "1:00s", "letter" => "BDST", "adjust" => "2:00", "month" => 4, "dow" => {"mindate" => "2", "dow" => 7}, "years" => 1942..1944}, {"time" => "1:00s", "letter" => "BST", "adjust" => "1:00", "month" => 9, "dow" => {"mindate" => "16", "dow" => 7}, "years" => 1944..1944}, {"time" => "1:00s", "letter" => "BDST", "adjust" => "2:00", "month" => 4, "dow" => {"mindate" => "2", "dow" => 1}, "years" => 1945..1945}, {"time" => "1:00s", "letter" => "BST", "adjust" => "1:00", "month" => 7, "dow" => {"mindate" => "9", "dow" => 7}, "years" => 1945..1945}, {"time" => "2:00s", "letter" => "GMT", "adjust" => "0", "month" => 10, "dow" => {"mindate" => "2", "dow" => 7}, "years" => 1945..1946}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "9", "dow" => 7}, "years" => 1946..1946}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 3, "years" => 1947..1947, "date" => "16"}, {"time" => "1:00s", "letter" => "BDST", "adjust" => "2:00", "month" => 4, "years" => 1947..1947, "date" => "13"}, {"time" => "1:00s", "letter" => "BST", "adjust" => "1:00", "month" => 8, "years" => 1947..1947, "date" => "10"}, {"time" => "2:00s", "letter" => "GMT", "adjust" => "0", "month" => 11, "years" => 1947..1947, "date" => "2"}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 3, "years" => 1948..1948, "date" => "14"}, {"time" => "2:00s", "letter" => "GMT", "adjust" => "0", "month" => 10, "years" => 1948..1948, "date" => "31"}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "years" => 1949..1949, "date" => "3"}, {"time" => "2:00s", "letter" => "GMT", "adjust" => "0", "month" => 10, "years" => 1949..1949, "date" => "30"}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "14", "dow" => 7}, "years" => 1950..1952}, {"time" => "2:00s", "letter" => "GMT", "adjust" => "0", "month" => 10, "dow" => {"mindate" => "21", "dow" => 7}, "years" => 1950..1952}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "16", "dow" => 7}, "years" => 1953..1953}, {"time" => "2:00s", "letter" => "GMT", "adjust" => "0", "month" => 10, "dow" => {"mindate" => "2", "dow" => 7}, "years" => 1953..1960}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "9", "dow" => 7}, "years" => 1954..1954}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "16", "dow" => 7}, "years" => 1955..1956}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "9", "dow" => 7}, "years" => 1957..1957}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "16", "dow" => 7}, "years" => 1958..1959}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "9", "dow" => 7}, "years" => 1960..1960}, {"time" => "2:00s", "lastdow" => 7, "letter" => "BST", "adjust" => "1:00", "month" => 3, "years" => 1961..1963}, {"time" => "2:00s", "letter" => "GMT", "adjust" => "0", "month" => 10, "dow" => {"mindate" => "23", "dow" => 7}, "years" => 1961..1968}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 3, "dow" => {"mindate" => "19", "dow" => 7}, "years" => 1964..1967}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 2, "years" => 1968..1968, "date" => "18"}, {"time" => "2:00s", "letter" => "BST", "adjust" => "1:00", "month" => 3, "dow" => {"mindate" => "16", "dow" => 7}, "years" => 1972..1980}, {"time" => "2:00s", "letter" => "GMT", "adjust" => "0", "month" => 10, "dow" => {"mindate" => "23", "dow" => 7}, "years" => 1972..1980}, {"time" => "1:00u", "lastdow" => 7, "letter" => "BST", "adjust" => "1:00", "month" => 3, "years" => 1981..1995}, {"time" => "1:00u", "letter" => "GMT", "adjust" => "0", "month" => 10, "dow" => {"mindate" => "23", "dow" => 7}, "years" => 1981..1989}, {"time" => "1:00u", "letter" => "GMT", "adjust" => "0", "month" => 10, "dow" => {"mindate" => "22", "dow" => 7}, "years" => 1990..1995}],
);
has @.zonedata = Array.new({"baseoffset" => "-0:25:00", "rules" => "", "until" => -2821651200}, {"baseoffset" => "-0:25:21", "rules" => "", "until" => -1691964000}, {"baseoffset" => "1:25", "rules" => "", "until" => -1680472800}, {"baseoffset" => "0:00", "rules" => "GB-Eire", "until" => -1517011200}, {"baseoffset" => "0:00", "rules" => "GB-Eire", "until" => -942012000}, {"baseoffset" => "1:00", "rules" => "", "until" => -733356000}, {"baseoffset" => "0:00", "rules" => "", "until" => -719445600}, {"baseoffset" => "1:00", "rules" => "", "until" => -699487200}, {"baseoffset" => "0:00", "rules" => "", "until" => -684972000}, {"baseoffset" => "0:00", "rules" => "GB-Eire", "until" => -37238400}, {"baseoffset" => "1:00", "rules" => "", "until" => 57722400}, {"baseoffset" => "0:00", "rules" => "GB-Eire", "until" => 820454400}, {"baseoffset" => "0:00", "rules" => "EU", "until" => Inf});

use v6;
use DateTime::TimeZone::Zone;
unit class DateTime::TimeZone::Zone::Europe::Warsaw does DateTime::TimeZone::Zone;
has %.rules = ( 
 C-Eur => [{:adjust("1:00"), :date("30"), :letter("S"), :month(4), :time("23:00"), :years(1916..1916)}, {:adjust("0"), :date("1"), :letter("-"), :month(10), :time("1:00"), :years(1916..1916)}, {:adjust("1:00"), :dow({:dow(1), :mindate("15")}), :letter("S"), :month(4), :time("2:00s"), :years(1917..1918)}, {:adjust("0"), :dow({:dow(1), :mindate("15")}), :letter("-"), :month(9), :time("2:00s"), :years(1917..1918)}, {:adjust("1:00"), :date("1"), :letter("S"), :month(4), :time("2:00s"), :years(1940..1940)}, {:adjust("0"), :date("2"), :letter("-"), :month(11), :time("2:00s"), :years(1942..1942)}, {:adjust("1:00"), :date("29"), :letter("S"), :month(3), :time("2:00s"), :years(1943..1943)}, {:adjust("0"), :date("4"), :letter("-"), :month(10), :time("2:00s"), :years(1943..1943)}, {:adjust("1:00"), :dow({:dow(1), :mindate("1")}), :letter("S"), :month(4), :time("2:00s"), :years(1944..1945)}, {:adjust("0"), :date("2"), :letter("-"), :month(10), :time("2:00s"), :years(1944..1944)}, {:adjust("0"), :date("16"), :letter("-"), :month(9), :time("2:00s"), :years(1945..1945)}, {:adjust("1:00"), :dow({:dow(7), :mindate("1")}), :letter("S"), :month(4), :time("2:00s"), :years(1977..1980)}, {:adjust("0"), :lastdow(7), :letter("-"), :month(9), :time("2:00s"), :years(1977..1977)}, {:adjust("0"), :date("1"), :letter("-"), :month(10), :time("2:00s"), :years(1978..1978)}, {:adjust("0"), :lastdow(7), :letter("-"), :month(9), :time("2:00s"), :years(1979..1995)}, {:adjust("1:00"), :lastdow(7), :letter("S"), :month(3), :time("2:00s"), :years(1981..Inf)}, {:adjust("0"), :lastdow(7), :letter("-"), :month(10), :time("2:00s"), :years(1996..Inf)}],
 EU => [{:adjust("1:00"), :dow({:dow(7), :mindate("1")}), :letter("S"), :month(4), :time("1:00u"), :years(1977..1980)}, {:adjust("0"), :lastdow(7), :letter("-"), :month(9), :time("1:00u"), :years(1977..1977)}, {:adjust("0"), :date("1"), :letter("-"), :month(10), :time("1:00u"), :years(1978..1978)}, {:adjust("0"), :lastdow(7), :letter("-"), :month(9), :time("1:00u"), :years(1979..1995)}, {:adjust("1:00"), :lastdow(7), :letter("S"), :month(3), :time("1:00u"), :years(1981..Inf)}, {:adjust("0"), :lastdow(7), :letter("-"), :month(10), :time("1:00u"), :years(1996..Inf)}],
 Poland => [{:adjust("0"), :date("16"), :letter("-"), :month(9), :time("2:00s"), :years(1918..1919)}, {:adjust("1:00"), :date("15"), :letter("S"), :month(4), :time("2:00s"), :years(1919..1919)}, {:adjust("1:00"), :date("3"), :letter("S"), :month(4), :time("2:00s"), :years(1944..1944)}, {:adjust("0"), :date("4"), :letter("-"), :month(10), :time("2:00"), :years(1944..1944)}, {:adjust("1:00"), :date("29"), :letter("S"), :month(4), :time("0:00"), :years(1945..1945)}, {:adjust("0"), :date("1"), :letter("-"), :month(11), :time("0:00"), :years(1945..1945)}, {:adjust("1:00"), :date("14"), :letter("S"), :month(4), :time("0:00s"), :years(1946..1946)}, {:adjust("0"), :date("7"), :letter("-"), :month(10), :time("2:00s"), :years(1946..1946)}, {:adjust("1:00"), :date("4"), :letter("S"), :month(5), :time("2:00s"), :years(1947..1947)}, {:adjust("0"), :dow({:dow(7), :mindate("1")}), :letter("-"), :month(10), :time("2:00s"), :years(1947..1949)}, {:adjust("1:00"), :date("18"), :letter("S"), :month(4), :time("2:00s"), :years(1948..1948)}, {:adjust("1:00"), :date("10"), :letter("S"), :month(4), :time("2:00s"), :years(1949..1949)}, {:adjust("1:00"), :date("2"), :letter("S"), :month(6), :time("1:00s"), :years(1957..1957)}, {:adjust("0"), :lastdow(7), :letter("-"), :month(9), :time("1:00s"), :years(1957..1958)}, {:adjust("1:00"), :date("30"), :letter("S"), :month(3), :time("1:00s"), :years(1958..1958)}, {:adjust("1:00"), :date("31"), :letter("S"), :month(5), :time("1:00s"), :years(1959..1959)}, {:adjust("0"), :dow({:dow(7), :mindate("1")}), :letter("-"), :month(10), :time("1:00s"), :years(1959..1961)}, {:adjust("1:00"), :date("3"), :letter("S"), :month(4), :time("1:00s"), :years(1960..1960)}, {:adjust("1:00"), :lastdow(7), :letter("S"), :month(5), :time("1:00s"), :years(1961..1964)}, {:adjust("0"), :lastdow(7), :letter("-"), :month(9), :time("1:00s"), :years(1962..1964)}],
 W-Eur => [{:adjust("1:00"), :dow({:dow(7), :mindate("1")}), :letter("S"), :month(4), :time("1:00s"), :years(1977..1980)}, {:adjust("0"), :lastdow(7), :letter("-"), :month(9), :time("1:00s"), :years(1977..1977)}, {:adjust("0"), :date("1"), :letter("-"), :month(10), :time("1:00s"), :years(1978..1978)}, {:adjust("0"), :lastdow(7), :letter("-"), :month(9), :time("1:00s"), :years(1979..1995)}, {:adjust("1:00"), :lastdow(7), :letter("S"), :month(3), :time("1:00s"), :years(1981..Inf)}, {:adjust("0"), :lastdow(7), :letter("-"), :month(10), :time("1:00s"), :years(1996..Inf)}],
);
has @.zonedata = [{:baseoffset("1:24:00"), :rules(""), :until(-2840140800)}, {:baseoffset("1:24:00"), :rules(""), :until(-1717027200)}, {:baseoffset("1:00"), :rules("C-Eur"), :until(-1618693200)}, {:baseoffset("2:00"), :rules("Poland"), :until(-1514764800)}, {:baseoffset("1:00"), :rules("Poland"), :until(-931730400)}, {:baseoffset("1:00"), :rules("C-Eur"), :until(-820540800)}, {:baseoffset("1:00"), :rules("Poland"), :until(220924800)}, {:baseoffset("1:00"), :rules("W-Eur"), :until(567993600)}, {:baseoffset("1:00"), :rules("EU"), :until(Inf)}]<>;

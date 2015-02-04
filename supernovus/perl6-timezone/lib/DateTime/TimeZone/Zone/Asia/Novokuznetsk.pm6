use v6;
use DateTime::TimeZone::Zone;
class DateTime::TimeZone::Zone::Asia::Novokuznetsk does DateTime::TimeZone::Zone;
has %.rules = ( 
 Russia => [{"time" => "23:00", "letter" => "MST", "adjust" => "1:00", "month" => 7, "years" => 1917..1917, "date" => "1"}, {"time" => "0:00", "letter" => "MMT", "adjust" => "0", "month" => 12, "years" => 1917..1917, "date" => "28"}, {"time" => "22:00", "letter" => "MDST", "adjust" => "2:00", "month" => 5, "years" => 1918..1918, "date" => "31"}, {"time" => "1:00", "letter" => "MST", "adjust" => "1:00", "month" => 9, "years" => 1918..1918, "date" => "16"}, {"time" => "23:00", "letter" => "MDST", "adjust" => "2:00", "month" => 5, "years" => 1919..1919, "date" => "31"}, {"time" => "2:00", "letter" => "S", "adjust" => "1:00", "month" => 7, "years" => 1919..1919, "date" => "1"}, {"time" => "0:00", "letter" => "-", "adjust" => "0", "month" => 8, "years" => 1919..1919, "date" => "16"}, {"time" => "23:00", "letter" => "S", "adjust" => "1:00", "month" => 2, "years" => 1921..1921, "date" => "14"}, {"time" => "23:00", "letter" => "M", "adjust" => "2:00", "month" => 3, "years" => 1921..1921, "date" => "20"}, {"time" => "0:00", "letter" => "S", "adjust" => "1:00", "month" => 9, "years" => 1921..1921, "date" => "1"}, {"time" => "0:00", "letter" => "-", "adjust" => "0", "month" => 10, "years" => 1921..1921, "date" => "1"}, {"time" => "0:00", "letter" => "S", "adjust" => "1:00", "month" => 4, "years" => 1981..1984, "date" => "1"}, {"time" => "0:00", "letter" => "-", "adjust" => "0", "month" => 10, "years" => 1981..1983, "date" => "1"}, {"time" => "2:00s", "lastdow" => 7, "letter" => "-", "adjust" => "0", "month" => 9, "years" => 1984..1991}, {"time" => "2:00s", "lastdow" => 7, "letter" => "S", "adjust" => "1:00", "month" => 3, "years" => 1985..1991}, {"time" => "23:00", "lastdow" => 6, "letter" => "S", "adjust" => "1:00", "month" => 3, "years" => 1992..1992}, {"time" => "23:00", "lastdow" => 6, "letter" => "-", "adjust" => "0", "month" => 9, "years" => 1992..1992}, {"time" => "2:00s", "lastdow" => 7, "letter" => "S", "adjust" => "1:00", "month" => 3, "years" => 1993..2010}, {"time" => "2:00s", "lastdow" => 7, "letter" => "-", "adjust" => "0", "month" => 9, "years" => 1993..1995}, {"time" => "2:00s", "lastdow" => 7, "letter" => "-", "adjust" => "0", "month" => 10, "years" => 1996..2010}],
);
has @.zonedata = Array.new({"baseoffset" => "5:48:48", "rules" => "", "until" => -1577491200}, {"baseoffset" => "6:00", "rules" => "", "until" => -1247529600}, {"baseoffset" => "7:00", "rules" => "Russia", "until" => 670384800}, {"baseoffset" => "6:00", "rules" => "Russia", "until" => 695786400}, {"baseoffset" => "7:00", "rules" => "Russia", "until" => 1269741600}, {"baseoffset" => "6:00", "rules" => "Russia", "until" => 1301191200}, {"baseoffset" => "7:00", "rules" => "", "until" => Inf});

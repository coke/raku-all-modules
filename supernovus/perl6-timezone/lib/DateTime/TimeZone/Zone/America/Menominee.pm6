use v6;
use DateTime::TimeZone::Zone;
class DateTime::TimeZone::Zone::America::Menominee does DateTime::TimeZone::Zone;
has %.rules = ( 
 Menominee => [{"time" => "2:00", "lastdow" => 7, "letter" => "D", "adjust" => "1:00", "month" => 4, "years" => 1946..1946}, {"time" => "2:00", "lastdow" => 7, "letter" => "S", "adjust" => "0", "month" => 9, "years" => 1946..1946}, {"time" => "2:00", "lastdow" => 7, "letter" => "D", "adjust" => "1:00", "month" => 4, "years" => 1966..1966}, {"time" => "2:00", "lastdow" => 7, "letter" => "S", "adjust" => "0", "month" => 10, "years" => 1966..1966}],
 US => [{"time" => "2:00", "lastdow" => 7, "letter" => "D", "adjust" => "1:00", "month" => 3, "years" => 1918..1919}, {"time" => "2:00", "lastdow" => 7, "letter" => "S", "adjust" => "0", "month" => 10, "years" => 1918..1919}, {"time" => "2:00", "letter" => "W", "adjust" => "1:00", "month" => 2, "years" => 1942..1942, "date" => "9"}, {"time" => "23:00u", "letter" => "P", "adjust" => "1:00", "month" => 8, "years" => 1945..1945, "date" => "14"}, {"time" => "2:00", "letter" => "S", "adjust" => "0", "month" => 9, "years" => 1945..1945, "date" => "30"}, {"time" => "2:00", "lastdow" => 7, "letter" => "S", "adjust" => "0", "month" => 10, "years" => 1967..2006}, {"time" => "2:00", "lastdow" => 7, "letter" => "D", "adjust" => "1:00", "month" => 4, "years" => 1967..1973}, {"time" => "2:00", "letter" => "D", "adjust" => "1:00", "month" => 1, "years" => 1974..1974, "date" => "6"}, {"time" => "2:00", "letter" => "D", "adjust" => "1:00", "month" => 2, "years" => 1975..1975, "date" => "23"}, {"time" => "2:00", "lastdow" => 7, "letter" => "D", "adjust" => "1:00", "month" => 4, "years" => 1976..1986}, {"time" => "2:00", "letter" => "D", "adjust" => "1:00", "month" => 4, "dow" => {"mindate" => "1", "dow" => 7}, "years" => 1987..2006}, {"time" => "2:00", "letter" => "D", "adjust" => "1:00", "month" => 3, "dow" => {"mindate" => "8", "dow" => 7}, "years" => 2007..Inf}, {"time" => "2:00", "letter" => "S", "adjust" => "0", "month" => 11, "dow" => {"mindate" => "1", "dow" => 7}, "years" => 2007..Inf}],
);
has @.zonedata = Array.new({"baseoffset" => "-5:50:27", "rules" => "", "until" => -2659780800}, {"baseoffset" => "-6:00", "rules" => "US", "until" => -757382400}, {"baseoffset" => "-6:00", "rules" => "Menominee", "until" => -21506400}, {"baseoffset" => "-5:00", "rules" => "", "until" => 104896800}, {"baseoffset" => "-6:00", "rules" => "US", "until" => Inf});

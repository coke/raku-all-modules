use v6;
use DateTime::TimeZone::Zone;
class DateTime::TimeZone::Zone::Etc::UCT does DateTime::TimeZone::Zone;
has %.rules = ( 
);
has @.zonedata = Array.new({"baseoffset" => "0", "rules" => "", "until" => Inf});

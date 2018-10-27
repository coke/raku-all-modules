use v6;
use DateTime::TimeZone::Zone;
unit class DateTime::TimeZone::Zone::America::Kentucky::Monticello does DateTime::TimeZone::Zone;
has %.rules = ( 
 US => [{:adjust("1:00"), :lastdow(7), :letter("D"), :month(3), :time("2:00"), :years(1918..1919)}, {:adjust("0"), :lastdow(7), :letter("S"), :month(10), :time("2:00"), :years(1918..1919)}, {:adjust("1:00"), :date("9"), :letter("W"), :month(2), :time("2:00"), :years(1942..1942)}, {:adjust("1:00"), :date("14"), :letter("P"), :month(8), :time("23:00u"), :years(1945..1945)}, {:adjust("0"), :date("30"), :letter("S"), :month(9), :time("2:00"), :years(1945..1945)}, {:adjust("0"), :lastdow(7), :letter("S"), :month(10), :time("2:00"), :years(1967..2006)}, {:adjust("1:00"), :lastdow(7), :letter("D"), :month(4), :time("2:00"), :years(1967..1973)}, {:adjust("1:00"), :date("6"), :letter("D"), :month(1), :time("2:00"), :years(1974..1974)}, {:adjust("1:00"), :date("23"), :letter("D"), :month(2), :time("2:00"), :years(1975..1975)}, {:adjust("1:00"), :lastdow(7), :letter("D"), :month(4), :time("2:00"), :years(1976..1986)}, {:adjust("1:00"), :dow({:dow(7), :mindate("1")}), :letter("D"), :month(4), :time("2:00"), :years(1987..2006)}, {:adjust("1:00"), :dow({:dow(7), :mindate("8")}), :letter("D"), :month(3), :time("2:00"), :years(2007..Inf)}, {:adjust("0"), :dow({:dow(7), :mindate("1")}), :letter("S"), :month(11), :time("2:00"), :years(2007..Inf)}],
);
has @.zonedata = [{:baseoffset("-5:39:24"), :rules(""), :until(-2717667600)}, {:baseoffset("-6:00"), :rules("US"), :until(-757382400)}, {:baseoffset("-6:00"), :rules(""), :until(-63158400)}, {:baseoffset("-6:00"), :rules("US"), :until(972784800)}, {:baseoffset("-5:00"), :rules("US"), :until(Inf)}]<>;

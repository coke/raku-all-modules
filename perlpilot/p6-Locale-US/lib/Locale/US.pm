module Locale::US;

my $data = "AL:ALABAMA
AK:ALASKA
AS:AMERICAN SAMOA
AZ:ARIZONA
AR:ARKANSAS
CA:CALIFORNIA
CO:COLORADO
CT:CONNECTICUT
DE:DELAWARE
DC:DISTRICT OF COLUMBIA
FM:FEDERATED STATES OF MICRONESIA
FL:FLORIDA
GA:GEORGIA
GU:GUAM
HI:HAWAII
ID:IDAHO
IL:ILLINOIS
IN:INDIANA
IA:IOWA
KS:KANSAS
KY:KENTUCKY
LA:LOUISIANA
ME:MAINE
MH:MARSHALL ISLANDS
MD:MARYLAND
MA:MASSACHUSETTS
MI:MICHIGAN
MN:MINNESOTA
MS:MISSISSIPPI
MO:MISSOURI
MT:MONTANA
NE:NEBRASKA
NV:NEVADA
NH:NEW HAMPSHIRE
NJ:NEW JERSEY
NM:NEW MEXICO
NY:NEW YORK
NC:NORTH CAROLINA
ND:NORTH DAKOTA
MP:NORTHERN MARIANA ISLANDS
OH:OHIO
OK:OKLAHOMA
OR:OREGON
PW:PALAU
PA:PENNSYLVANIA
PR:PUERTO RICO
RI:RHODE ISLAND
SC:SOUTH CAROLINA
SD:SOUTH DAKOTA
TN:TENNESSEE
TX:TEXAS
UT:UTAH
VT:VERMONT
VI:VIRGIN ISLANDS
VA:VIRGINIA
WA:WASHINGTON
WV:WEST VIRGINIA
WI:WISCONSIN
WY:WYOMING";

my @states; my @codes;
my %code-to-state = $data.lines.map:{ 
    my ($code,$state) = .split(':'); 
    push @codes, $code; 
    push @states, $state; 
    $code => $state
};
my %state-to-code = %code-to-state.invert;

sub state-to-code($state) is export { return %state-to-code{$state.uc}; }
sub code-to-state($code) is export { return %code-to-state{$code.uc}; }
sub all-state-names() is export { return @states; }
sub all-state-codes() is export { return @codes; }

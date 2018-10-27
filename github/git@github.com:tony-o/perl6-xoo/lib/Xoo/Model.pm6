use Xoo::Searchable;
use Xoo::Row;
unit role Xoo::Model[Str $table-name, Str $row-class?] does Xoo::Searchable;

has $!table-name;
has $!db;
has $.quote;
has $!model-class;
has $!driver;
has $!row-class;
has $!dbo;

sub anon-row {
  my $cx = class :: does Xoo::Row {};
  $cx;
}

multi submethod BUILD (:$!driver, :$!db, :$!quote, :$!dbo, :@columns?, :@relations?) {
  CATCH { default { .say; } }
  if @columns {
    try {
      CATCH { die '@columns supplied to model but unable to bind: '~$_; };
      my $attr = self.^attributes.first: { $_.Str eq '@.columns' };
      die '@columns supplied but no attribute in model' unless $attr;
      $attr.set_value(self, @columns);
    };
  }
  if @relations {
    try {
      CATCH { die '@columns supplied to model but unable to bind: '~$_; };
      my $attr = self.^attributes.first: { $_.Str eq '@.relations' };
      die '@relations supplied but no attribute in model' unless $attr;
      $attr.set_value(self, @relations);
    };
  }
  $!table-name = $table-name;
  $!quote      = $!driver eq 'mysql'
    ?? { identifier => '`', value => '"' }
    !! { identifier => '"', value => '\'' };
  $!model-class = $?OUTERS::CLASS;
  if $row-class.defined {
    my $row-class-loaded = (try require ::($row-class)) === Nil;
    if $row-class-loaded {
      $!row-class = anon-row;
    } else {
      $!row-class = ::($row-class);
    }
  } else {
    my @row-model = $!model-class.^name.split('::');
    for @row-model -> $e is rw {
      if $e eq 'Model' {
        $e = 'Row';
        last;
      }
    }
    my $r-str = @row-model.join('::');
    my $use-anon = (try require ::($r-str)) === Nil;
    if $use-anon {
      $!row-class = anon-row;
    } else {
      $!row-class = ::("$r-str") // anon-row;
    }
  }
}

method table-name { $!table-name; }
method db         { $!db; }
method dbo        { $!dbo; }
method driver     { $!driver; }
method row        { $!row-class; }
method new-row($field-data?) {
  my %field-data = $field-data ?? ($field-data ~~ Block ?? $field-data.() !! $field-data) !! ();
  self.row.new(:%field-data, :driver(self.driver), :db(self.db), :model(self), dbo => self.dbo, :is-dirty(True));
}

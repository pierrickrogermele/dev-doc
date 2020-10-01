use YAML::XS;
use Data::Dumper;
my $data = YAML::XS::LoadFile('myfile.yml');
print Dumper($data);

YAML::XS::DumpFile('output.yml', $data);

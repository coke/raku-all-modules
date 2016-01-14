use v6;
use Test;
use BSON::Document;

#-------------------------------------------------------------------------------
subtest {

  my BSON::Document $d .= new;
  $d.autovivify(True);

  $d<a><b><c><d><e><f1><g><h><i><j><h><i><j> = ('a' ... 'z') Z=> 120..145;
  $d<a><b><c><d><e><f2><g><h><i><j><h><i><j> = ('a' ... 'z') Z=> 120..145;

  is $d<a><b><c><d><e><f1><g><h><i><j><h><i><j><a>,
     120,
     "Very deep ...<j><a> = $d<a><b><c><d><e><f1><g><h><i><j><h><i><j><a>";
  is $d<a><b><c><d><e><f2><g><h><i><j><h><i><j><a>,
     120,
     "Very deep ...<j><a> = $d<a><b><c><d><e><f2><g><h><i><j><h><i><j><a>";

  my Buf $b = $d.encode;

  # Handcrafted encoded BSON data
  #
  my Buf $etst = Buf.new(
    0x1b, 0x02, 0x00, 0x00,
      0x03, 0x61, 0x00,
      0x13, 0x02, 0x00, 0x00,
        0x03, 0x62, 0x00,
        0x0b, 0x02, 0x00, 0x00,
          0x03, 0x63, 0x00,
          0x03, 0x02, 0x00, 0x00,
            0x03, 0x64, 0x00,
            0xfb, 0x01, 0x00, 0x00,
              0x03, 0x65, 0x00,
              0xf3, 0x01, 0x00, 0x00,
                0x03, 0x66, 0x31, 0x00,         # C-DOCUMENT 'f1'
                0xf3, 0x00, 0x00, 0x00,
                  0x03, 0x67, 0x00,
                  0xeb, 0x00, 0x00, 0x00,
                    0x03, 0x68, 0x00,
                    0xe3, 0x00, 0x00, 0x00,
                      0x03, 0x69, 0x00,
                      0xdb, 0x00, 0x00, 0x00,
                        0x03, 0x6a, 0x00,
                        0xd3, 0x00, 0x00, 0x00,
                          0x03, 0x68, 0x00,
                          0xcb, 0x00, 0x00, 0x00,
                            0x03, 0x69, 0x00,
                            0xc3, 0x00, 0x00, 0x00,
                              0x03, 0x6a, 0x00,
                              0xbb, 0x00, 0x00, 0x00,
                              0x10,  0x61, 0x00,  0x78, 0x00, 0x00, 0x00,
                              0x10,  0x62, 0x00,  0x79, 0x00, 0x00, 0x00,
                              0x10,  0x63, 0x00,  0x7a, 0x00, 0x00, 0x00,
                              0x10,  0x64, 0x00,  0x7b, 0x00, 0x00, 0x00,
                              0x10,  0x65, 0x00,  0x7c, 0x00, 0x00, 0x00,
                              0x10,  0x66, 0x00,  0x7d, 0x00, 0x00, 0x00,
                              0x10,  0x67, 0x00,  0x7e, 0x00, 0x00, 0x00,
                              0x10,  0x68, 0x00,  0x7f, 0x00, 0x00, 0x00,
                              0x10,  0x69, 0x00,  0x80, 0x00, 0x00, 0x00,
                              0x10,  0x6a, 0x00,  0x81, 0x00, 0x00, 0x00,
                              0x10,  0x6b, 0x00,  0x82, 0x00, 0x00, 0x00,
                              0x10,  0x6c, 0x00,  0x83, 0x00, 0x00, 0x00,
                              0x10,  0x6d, 0x00,  0x84, 0x00, 0x00, 0x00,
                              0x10,  0x6e, 0x00,  0x85, 0x00, 0x00, 0x00,
                              0x10,  0x6f, 0x00,  0x86, 0x00, 0x00, 0x00,
                              0x10,  0x70, 0x00,  0x87, 0x00, 0x00, 0x00,
                              0x10,  0x71, 0x00,  0x88, 0x00, 0x00, 0x00,
                              0x10,  0x72, 0x00,  0x89, 0x00, 0x00, 0x00,
                              0x10,  0x73, 0x00,  0x8a, 0x00, 0x00, 0x00,
                              0x10,  0x74, 0x00,  0x8b, 0x00, 0x00, 0x00,
                              0x10,  0x75, 0x00,  0x8c, 0x00, 0x00, 0x00,
                              0x10,  0x76, 0x00,  0x8d, 0x00, 0x00, 0x00,
                              0x10,  0x77, 0x00,  0x8e, 0x00, 0x00, 0x00,
                              0x10,  0x78, 0x00,  0x8f, 0x00, 0x00, 0x00,
                              0x10,  0x79, 0x00,  0x90, 0x00, 0x00, 0x00,
                              0x10,  0x7a, 0x00,  0x91, 0x00, 0x00, 0x00,
                            0x00,
                          0x00,
                        0x00,
                      0x00,
                    0x00,
                  0x00,
                0x00,
              0x00,
              0x03, 0x66, 0x32, 0x00,         # C-DOCUMENT 'f2'
              0xf3, 0x00, 0x00, 0x00,
                0x03, 0x67, 0x00,
                0xeb, 0x00, 0x00, 0x00,
                  0x03, 0x68, 0x00,
                  0xe3, 0x00, 0x00, 0x00,
                    0x03, 0x69, 0x00,
                    0xdb, 0x00, 0x00, 0x00,
                      0x03, 0x6a, 0x00,
                      0xd3, 0x00, 0x00, 0x00,
                        0x03, 0x68, 0x00,
                          0xcb, 0x00, 0x00, 0x00,
                            0x03, 0x69, 0x00,
                            0xc3, 0x00, 0x00, 0x00,
                              0x03, 0x6a, 0x00,
                              0xbb, 0x00, 0x00, 0x00,
                                0x10,  0x61, 0x00,  0x78, 0x00, 0x00, 0x00,
                                0x10,  0x62, 0x00,  0x79, 0x00, 0x00, 0x00,
                                0x10,  0x63, 0x00,  0x7a, 0x00, 0x00, 0x00,
                                0x10,  0x64, 0x00,  0x7b, 0x00, 0x00, 0x00,
                                0x10,  0x65, 0x00,  0x7c, 0x00, 0x00, 0x00,
                                0x10,  0x66, 0x00,  0x7d, 0x00, 0x00, 0x00,
                                0x10,  0x67, 0x00,  0x7e, 0x00, 0x00, 0x00,
                                0x10,  0x68, 0x00,  0x7f, 0x00, 0x00, 0x00,
                                0x10,  0x69, 0x00,  0x80, 0x00, 0x00, 0x00,
                                0x10,  0x6a, 0x00,  0x81, 0x00, 0x00, 0x00,
                                0x10,  0x6b, 0x00,  0x82, 0x00, 0x00, 0x00,
                                0x10,  0x6c, 0x00,  0x83, 0x00, 0x00, 0x00,
                                0x10,  0x6d, 0x00,  0x84, 0x00, 0x00, 0x00,
                                0x10,  0x6e, 0x00,  0x85, 0x00, 0x00, 0x00,
                                0x10,  0x6f, 0x00,  0x86, 0x00, 0x00, 0x00,
                                0x10,  0x70, 0x00,  0x87, 0x00, 0x00, 0x00,
                                0x10,  0x71, 0x00,  0x88, 0x00, 0x00, 0x00,
                                0x10,  0x72, 0x00,  0x89, 0x00, 0x00, 0x00,
                                0x10,  0x73, 0x00,  0x8a, 0x00, 0x00, 0x00,
                                0x10,  0x74, 0x00,  0x8b, 0x00, 0x00, 0x00,
                                0x10,  0x75, 0x00,  0x8c, 0x00, 0x00, 0x00,
                                0x10,  0x76, 0x00,  0x8d, 0x00, 0x00, 0x00,
                                0x10,  0x77, 0x00,  0x8e, 0x00, 0x00, 0x00,
                                0x10,  0x78, 0x00,  0x8f, 0x00, 0x00, 0x00,
                                0x10,  0x79, 0x00,  0x90, 0x00, 0x00, 0x00,
                                0x10,  0x7a, 0x00,  0x91, 0x00, 0x00, 0x00,
                              0x00,
                            0x00,
                          0x00,
                        0x00,
                      0x00,
                    0x00,
                  0x00,
                0x00,
              0x00,
            0x00,
          0x00,
        0x00,
      0x00,
    0x00,
  );

  is-deeply $b, $etst, 'Buf compare';

  my BSON::Document $d2 .= new;
  $d2.decode($b);

  is $d2<a><b><c><d><e><f1><g><h><i><j><h><i><j><c>,
     122,
     "Very deep ...<j><c> = $d<a><b><c><d><e><f1><g><h><i><j><h><i><j><c>";
  is $d2<a><b><c><d><e><f2><g><h><i><j><h><i><j><c>,
     122,
     "Very deep ...<j><c> = $d<a><b><c><d><e><f2><g><h><i><j><h><i><j><c>";

  my $b2 = $d2.encode;
  is-deeply $etst, $b, 'Buf compare of encoded decode';
  

}, "Autovivication";


#-------------------------------------------------------------------------------
# Cleanup
#
done-testing;
exit(0);




















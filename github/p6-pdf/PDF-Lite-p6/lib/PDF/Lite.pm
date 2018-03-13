use v6;

use PDF:ver(v0.2.8+);

#| A minimal class for manipulating PDF graphical content
class PDF::Lite:ver<0.0.3>
    is PDF {

    use PDF::COS;
    use PDF::COS::Tie;
    use PDF::COS::Tie::Hash;
    use PDF::COS::Loader;
    use PDF::COS::Stream;
    use PDF::COS::Util :from-ast;

    use PDF::Content:ver(v0.1.0+);
    use PDF::Content::Graphics;
    use PDF::Content::Page;
    use PDF::Content::PageNode;
    use PDF::Content::PageTree;
    use PDF::Content::Resourced;
    use PDF::Content::ResourceDict;
    use PDF::Content::XObject;
    use PDF::Content::Font;

    my role ResourceDict
	does PDF::COS::Tie::Hash
	does PDF::Content::ResourceDict {
            has PDF::Content::Font %.Font  is entry;
	    has PDF::COS::Stream %.XObject is entry;
            has PDF::COS::Dict $.ExtGState is entry;
    }

    my class XObject-Form
        is PDF::COS::Stream
        does PDF::Content::XObject['Form']
        does PDF::Content::Resourced
        does PDF::Content::Graphics {
            has ResourceDict $.Resources is entry;
    }

    my class XObject-Image
        is PDF::COS::Stream
        does PDF::Content::XObject['Image'] {
    }

    my class Loader is PDF::COS::Loader {
        multi method load-delegate(Hash :$dict! where {from-ast($_) ~~ 'Form' given  .<Subtype>}) {
            XObject-Form
        }
        multi method load-delegate(Hash :$dict! where {from-ast($_) ~~ 'Image' given  .<Subtype>}) {
            XObject-Image
        }
        multi method load-delegate(Hash :$dict! where {from-ast($_) ~~ 'Pattern' given  .<Type>}) {
            XObject-Form
        }
    }
    PDF::COS.loader = Loader;

    my role Page
	does PDF::COS::Tie::Hash
	does PDF::Content::Page
	does PDF::Content::PageNode {

 	has ResourceDict $.Resources is entry(:inherit);
	#| inheritable page properties
	has Numeric @.MediaBox is entry(:inherit,:len(4));
	has Numeric @.CropBox  is entry(:inherit,:len(4));
	has Numeric @.BleedBox is entry(:len(4));
	has Numeric @.TrimBox  is entry(:len(4));
	has Numeric @.ArtBox   is entry(:len(4));

        my subset NinetyDegreeAngle of Int where { $_ %% 90}
        has NinetyDegreeAngle $.Rotate is entry(:inherit);

	my subset StreamOrArray where PDF::COS::Stream | Array;
	has StreamOrArray $.Contents is entry;

        my subset ImageFile of Str where /:i '.'('png'|'svg'|'pdf') $/;
        method save-page-as(ImageFile $outfile) {
            require PDF::Content::Cairo;
            PDF::Content::Cairo.save-page-as(self, $outfile);
        }
    }

    my role Pages
	does PDF::COS::Tie::Hash
	does PDF::Content::PageNode
	does PDF::Content::PageTree {

	has ResourceDict $.Resources is entry(:inherit);
	#| inheritable page properties
	has Numeric @.MediaBox is entry(:inherit,:len(4));
	has Numeric @.CropBox  is entry(:inherit,:len(4));

	has Page @.Kids        is entry(:required, :indirect);
        has UInt $.Count       is entry(:required);
    }

    my role Catalog
	does PDF::COS::Tie::Hash {
	has Pages $.Pages is entry(:required, :indirect);

	method cb-finish {
	    self.Pages.?cb-finish;
	}

    }

    has Catalog $.Root is entry(:required, :indirect);

    method cb-init {
	self<Root> //= { :Type( :name<Catalog> ), :Pages{ :Type( :name<Pages> ), :Kids[], :Count(0), } };
    }

    BEGIN for <page add-page add-pages delete-page insert-page page-count media-box crop-box bleed-box trim-box art-box core-font use-font> -> $meth {
        $?CLASS.^add_method($meth,  method (|a) { self.Root.Pages."$meth"(|a) });
    }

}

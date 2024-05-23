require 'test/unit'

require 'rinchi-gem'
include RinchiGem

class RinchiGemTest < Test::Unit::TestCase
  # RInChi/examples/Esterification_01.txt
  def test_esterification
    rct_01 = File.read('./test/data/esterification/rct_01.mol')
    rct_02 = File.read('./test/data/esterification/rct_02.mol')
    prd_01 = File.read('./test/data/esterification/prd_01.mol')
    prd_02 = File.read('./test/data/esterification/prd_02.mol')
    agt_01 = File.read('./test/data/esterification/agt_01.mol')

    rcts = Rinchi::MolVect.new
    [rct_01, rct_02].each { |i| rcts.push(i) }

    prds = Rinchi::MolVect.new
    [prd_01, prd_02].each { |i| prds.push(i) }

    agts = Rinchi::MolVect.new
    [agt_01].each { |i| agts.push(i) }

    rinchi_string, long_key, short_key, web_key = Rinchi.convert(rcts, prds, agts)

    correct_rinchi = 'RInChI=1.00.1S/C2H4O2/c1-2(3)4/h1H3,(H,3,4)!C2H6O/c1-2-3/h3H,2H2,1H3<>C4H8O2/c1-3-6-4(2)5/h3H2,1-2H3!H2O/h1H2<>H2O4S/c1-5(2,3)4/h(H2,1,2,3,4)/d+'
    correct_long = 'Long-RInChIKey=SA-FUHFF-QTBSBXVTEAMEQO-UHFFFAOYSA-N-LFQSCWFLJHTTHZ-UHFFFAOYSA-N--XEKOWRVHYACXOJ-UHFFFAOYSA-N-XLYOFNOQVPJJNP-UHFFFAOYSA-N--QAOWNCQODCNURD-UHFFFAOYSA-N'
    correct_short = 'Short-RInChIKey=SA-FUHFF-JJFIATRHOH-UDXZTNISGZ-QAOWNCQODC-NUHFF-NUHFF-NUHFF-ZZZ'
    correct_web = 'Web-RInChIKey=SMUHAWIQPXIVCEVKG-NUHFFFADPSCTJSA'

    assert_equal(rinchi_string, correct_rinchi)
    assert_equal(long_key, correct_long)
    assert_equal(short_key, correct_short)
    assert_equal(web_key, correct_web)
  end

  # RInChi/examples/1_reactant_-_no_structure
  def test_1_reactant_X_no_structure
    rct_01 = File.read('./test/data/1_reactant_-_no_structure/rct_01.mol')
    prd_01 = File.read('./test/data/1_reactant_-_no_structure/prd_01.mol')

    rcts = Rinchi::MolVect.new
    [rct_01].each { |i| rcts.push(i) }

    prds = Rinchi::MolVect.new
    [prd_01].each { |i| prds.push(i) }

    agts = Rinchi::MolVect.new
    [].each { |i| agts.push(i) }

    rinchi_string, long_key, short_key, web_key = Rinchi.convert(rcts, prds, agts)

    # RInChi/examples/Esterification_01.txt
    correct_rinchi = 'RInChI=1.00.1S/<>C6H10O/c7-6-4-2-1-3-5-6/h4,7H,1-3,5H2/d-/u1-0-0'
    correct_long = 'Long-RInChIKey=SA-BUHFF-MOSFIJXAXDLOML-UHFFFAOYSA-N--QHDHNVFIKWGRJR-UHFFFAOYSA-N'
    correct_short = 'Short-RInChIKey=SA-BUHFF-UHFFFADPSC-QHDHNVFIKW-UHFFFADPSC-NUHFF-NUHFF-NUHFF-AZZ'
    correct_web = 'Web-RInChIKey=NVRPNKTYVJSLDPIVQ-NUHFFFADPSCTJSA'

    assert_equal(rinchi_string, correct_rinchi)
    assert_equal(long_key, correct_long)
    assert_equal(short_key, correct_short)
    assert_equal(web_key, correct_web)
  end

  # RInChi/examples/Inverted_stereochemistry
  def test_Inverted_stereochemistry
    rct_01 = File.read('./test/data/Inverted_stereochemistry/rct_01.mol')
    prd_01 = File.read('./test/data/Inverted_stereochemistry/prd_01.mol')

    rcts = Rinchi::MolVect.new
    [rct_01].each { |i| rcts.push(i) }

    prds = Rinchi::MolVect.new
    [prd_01].each { |i| prds.push(i) }

    agts = Rinchi::MolVect.new
    [].each { |i| agts.push(i) }

    rinchi_string, long_key, short_key, web_key = Rinchi.convert(rcts, prds, agts)

    # RInChi/examples/Esterification_01.txt
    correct_rinchi = 'RInChI=1.00.1S/CBrClFI/c2-1(3,4)5/t1-/m0/s1<>CBrClFI/c2-1(3,4)5/t1-/m1/s1/d+'
    correct_long = 'Long-RInChIKey=SA-FUHFF-XEGUVFFZWHRVAV-SFOWXEAESA-N--XEGUVFFZWHRVAV-PVQJCKRUSA-N'
    correct_short = 'Short-RInChIKey=SA-FUHFF-XEGUVFFZWH-XEGUVFFZWH-UHFFFADPSC-NYRHR-NAYUW-NUHFF-ZZZ'
    correct_web = 'Web-RInChIKey=OMADXNIUVSMMAGAIO-NUAXZUCYELSRHSA'

    assert_equal(rinchi_string, correct_rinchi)
    assert_equal(long_key, correct_long)
    assert_equal(short_key, correct_short)
    assert_equal(web_key, correct_web)
  end
end

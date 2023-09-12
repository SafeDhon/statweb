import 'package:flutter/material.dart';

import 'package:statweb/states/eBook/eBook_class.dart';
import 'package:statweb/states/eBook/eBook_constant.dart';

double space = 20;
double pictureH = 160;

List<EBookPage> ebookU2 = [
  EBookPage(
      unit: 2,
      page: 1,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ebookTextWithTab(
              'เมื่อต้องการหาความน่าจะเป็นที่เป็นไปได้ทั้งหมดของแต่ละเหตุการณ์ที่เกิดขึ้น แทนที่จะหาความน่าจะเป็นทีละเหตุการณ์จนครบทุกเหตุการณ์ที่เป็นไปได้ สามารถเปลี่ยนเหตุการณ์ให้ไปอยู่ในรูปของตัวแปรสุ่ม เพื่อนำไปสร้างฟังก์ชันความน่าจะเป็น ตามค่าของตัวแปรสุ่มที่เป็นไปได้ทั้งหมด'),
          SizedBox(height: space),
          ebookTextHead1('2.1 	ตัวแปรสุ่ม '),
          SizedBox(height: space),
          ebookTextWithTab(
              '	นิยามที่ 2.1  ตัวแปรสุ่ม (Random Variable)  คือ ฟังก์ชันที่มีค่าเป็นจำนวนจริง ซึ่งกำหนดโดยแต่ละสมาชิกใน Sample Space ใช้อักษรตัวใหญ่เป็นสัญลักษณ์แทน เช่น  X , Y , Z ส่วนค่าของตัวแปรสุ่ม ใช้อักษรตัวเล็ก เช่น   ตัวอย่างเช่น  ให้  X แทนจำนวนครั้งของการเกิดหัว ในการโยนเหรียญ 3 ครั้ง '),
          SizedBox(height: space),
          ebookMath(r"X = \{x_1,x_2,x_3,x_4\} = \{0,1,2,3\}"),
          SizedBox(height: space),
          ebookTextWithTab('ตัวแปรสุ่มแบ่งออกเป็น 2 ชนิด คือ '),
          SizedBox(height: space),
          ebookTextWithTab(
              '1.   ตัวแปรสุ่มไม่ต่อเนื่อง (Discrete Random Variable) เป็นตัวแปรสุ่มที่มีพิสัย ซึ่งมีจำนวนตัวเลขเป็นจำนวนที่นับได้ หรือมีจำนวนจำกัด เช่น ตัวแปรสุ่ม X คือ {0,1,2,3} หรือ X = {0,0.5,1.0,1.5,2.0}  ซึ่งตัวแปรสุ่ม X มีจำนวนจำกัด 5 จำนวน หรือตัวแปรสุ่ม X  คือ {0,1,2,3,…} ซึ่งตัวแปรสุ่ม X มีค่าเป็นอนันต์ แต่สามารถนับได้'),
          SizedBox(height: space),
          ebookTextWithTab(
              '2.  	ตัวแปรสุ่มต่อเนื่อง (Continuous Random Variable) เป็นตัวแปรสุ่มที่มีจำนวนตัวเลขมากเป็นอนันต์จนนับไม่ได้ เช่น ค่าของคัวแปรสุ่ม X ในช่วง 0 ≤ X ≤ 1'),
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=iqhuVXEAzgQ',
      music_url: 'https://www.youtube.com/watch?v=fX7k3W-2BMM',
      quiz: [2, 'Random Variable']),
  EBookPage(
      unit: 2,
      page: 2,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ebookTextHead1('2.2 	การแจกแจงความน่าจะเป็นแบบไม่ต่อเนื่อง '),
          SizedBox(height: space),
          spanText([
            ebookTextSpan('นิยามที่ 2.2', 'bold'),
            ebookTextSpan(
                '  ฟังก์ชัน f(x) เป็นฟังก์ชันความน่าจะเป็นของตัวแปรสุ่มไม่ต่อเนื่อง X ใด ๆ สำหรับแต่ละค่า X  มีคุณสมบัติ ดังนี้',
                'regular')
          ]),
          SizedBox(height: space),
          ebookTextWithTab('1. f(x) ≥ 0'),
          ebookTextWithTab('2. ∑ f(x) = 1'),
          ebookTextWithTab('3. f(x) = P(X=x)  เช่น  f(3) = P(X=3)'),
          SizedBox(height: space),
          spanText([
            ebookTextSpan('นิยามที่ 2.3', 'bold'),
            ebookTextSpan(
                '  ฟังก์ชันความน่าจะเป็นสะสมของตัวแปรสุ่มไม่ต่อเนื่อง X แทนด้วย F(X) คือ F(x) = P(X≤x)∑',
                'regular')
          ]),
          SizedBox(height: space),
          ebookTextWithTab(
              'เช่น F(3) = P(X≤3) = P(X=0) + P(X=1) + P(X=2) + P(X=3)'),
          SizedBox(height: space),
          ebookTextWithTab(
              'กรณีการหาค่าความน่าจะเป็นสะสมที่เป็นช่วง P(a<X≤b) = F(b) - F(a)'),
          SizedBox(height: space),
          ebookImage('ebooks%2F2_1.png?alt=media&token=61622f8f-6e43-4053-9a34-e52fbe267e19', pictureH),
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=iqhuVXEAzgQ',
      music_url: 'https://www.youtube.com/watch?v=DyiPr9jkW38',
      quiz: [2, 'Random Variable']),
  EBookPage(
      unit: 2,
      page: 3,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ebookTextHead1('2.3 	การแจกแจงความน่าจะเป็นร่วมกัน  '),
          SizedBox(height: space),
          ebookTextWithTab(
              'ในการทดลองบางอย่าง  ผลการทดลองที่สนใจอาจจะขึ้นอยู่กับค่าของตัวแปรสุ่มหลายตัวแปร ดังนั้นในการพิจารณาหาค่าความน่าจะเป็นในกรณีนี้ จะใช้หลักการแจกแจงความน่าจะเป็นร่วมกัน (Joint Probability Distributions) โดยในหลักสูตรนี้จะพิจารณาเฉพาะ 2 ตัวแปรเท่านั้น'),
          SizedBox(height: space),
          spanText([
            ebookTextSpan('นิยามที่ 2.3.1', 'bold'),
            ebookTextSpan(
                '  กำหนดให้  X และ Y เป็นตัวแปรสุ่มไม่ต่อเนื่อง ฟังก์ชันความน่าจะเป็นร่วมกันของ  X และ Y ใช้สัญลักษณ์ f(x,y) = P(X=x,Y=y) เช่น ในการตรวจซ่อมโทรทัศน์เครื่องหนึ่ง ให้',
                'regular')
          ]),
          SizedBox(height: space),
          ebookTextWithTab('X แทน อายุของโทรทัศน์ (ปี)'),
          ebookTextWithTab('Y แทน จำนวนหลอดที่เสีย'),
          SizedBox(height: space),
          ebookTextWithTab(
              'f(5,3) = P(X=5,Y=3) หมายความว่า ความน่าจะเป็นที่โทรทัศน์เครื่องนี้ มีอายุ 5 ปี และต้องเปลี่ยนหลอด 3 หลอด เป็นเท่าใด?'),
          SizedBox(height: space),
          spanText([
            ebookTextSpan('นิยามที่ 2.3.2', 'bold'),
            ebookTextSpan(
                '   เป็นฟังก์ชันความน่าจะเป็นร่วมของตัวแปรสุ่มไม่ต่อเนื่อง X และ Y ถ้า',
                'regular')
          ]),
          SizedBox(height: space),
          ebookTextWithTab('1. f(x,y) ≥ 0   สำหรับทุกค่าของ  (x,y)'),
          ebookTextWithTab('2. ∑∑f(x,y) = 1'),
          ebookTextWithTab(
              '3. P[(X,Y) ∈ A] = ∑∑f(x,y) เมื่อ A เป็นพื้นที่บนระนาบ XY'),
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=iqhuVXEAzgQ',
      music_url: 'https://www.youtube.com/watch?v=FXl9BpEWeI8',
      quiz: [2, 'Random Variable']),
  EBookPage(
      unit: 2,
      page: 4,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          spanText([
            ebookTextSpan('นิยามที่ 2.3.3', 'bold'),
            ebookTextSpan(
                '  ผลรวมการแจกแจงของ X (Marginal Distribution of X ; g(x)  และ  Y (Marginal Distribution of Y :  h(y)',
                'regular')
          ]),
          SizedBox(height: space),
          Row(
            children: [
              ebookTextWithTab('  '),
              ebookMath(r"         g(x) = \sum_{y} f(x,y)"),
            ],
          ),
          Row(
            children: [
              ebookTextWithTab('  '),
              ebookMath(r"         h(y) = \sum_{x} f(x,y)"),
            ],
          ),
          SizedBox(height: space),
          spanText([
            ebookTextSpan('นิยามที่ 2.3.4', 'bold'),
            ebookTextSpan(
                '  การแจกแจงความน่าจะเป็นร่วมกันแบบมีเงื่อนไข', 'regular')
          ]),
          SizedBox(height: space),
          Row(
            children: [
              ebookTextWithTab('  '),
              ebookMath(
                  r"         P(A|B) = \frac {P(A{\cap}B)} {P(A)},P(A) > 0"),
            ],
          ),
          SizedBox(height: space),
          ebookText(
              'ให้ 	A เป็นเหตุการณ์ที่ตัวแปรสุ่ม X = x และ 	B เป็นเหตุการณ์ที่ตัวแปรสุ่ม Y = y   ดังนั้น'),
          SizedBox(height: space),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ebookMath(r"P(Y=y|X=x) = \frac {P(X=x,Y=y)} {P(X=x)}"),
                ebookTextWithTab('P(X=x) > 0 หรือเขียนใหม่ได้เป็น'),
              ],
            ),
          ),
          SizedBox(height: space),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ebookTextWithTab('                    '),
                ebookMath(r"f(y|x) = \frac {f(x,y)} {g(x)}"),
                ebookTextWithTab('g(x) > 0 ทำนองเดียวกัน'),
              ],
            ),
          ),
          SizedBox(height: space),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ebookTextWithTab('                    '),
                ebookMath(r"f(x|y) = \frac {f(x,y)} {h(y)}"),
                ebookTextWithTab('h(y) > 0'),
              ],
            ),
          ),
          SizedBox(height: space),
          spanText([
            ebookTextSpan('นิยามที่ 2.3.5', 'bold'),
            ebookTextSpan(
                '  กรณีที่ X และ  Y  เป็นอิสระต่อกัน จะได้ f(x,y) = g(x) h(x) สำหรับทุกค่าของ x และ y',
                'regular')
          ]),
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=52R9V6Qvl0A',
      music_url: 'https://www.youtube.com/watch?v=64aNeYsa6Iw',
      quiz: [2, 'Random Variable']),
  EBookPage(
      unit: 2,
      page: 5,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ebookTextHead1('2.4 	กฎการคาดหวังทางคณิตศาสตร์'),
          SizedBox(height: space),
          spanText([
            ebookTextSpan('นิยาม 2.4.1', 'bold'),
            ebookTextSpan(
                '  X เป็นตัวแปรสุ่มที่มีฟังก์ชันความน่าจะเป็น f(x) ค่าคาดหวังของ X แทนด้วย E(X) โดย E(X) = ∑ x f(x); X เป็นตัวแปรสุ่มชนิดไม่ต่อเนื่อง',
                'regular')
          ]),
          SizedBox(height: space),
          spanText([
            ebookTextSpan('นิยาม 2.4.2', 'bold'),
            ebookTextSpan('  กฎของค่าคาดหวัง', 'regular')
          ]),
          SizedBox(height: space),
          ebookTextWithTab(
              '1.   E(a) = a   เมื่อ a เป็นค่าคงที่ใด ๆ เช่น  E(5) = 5'),
          SizedBox(height: space),
          ebookTextWithTab('2.    E(aX) = aE(X)	 เช่น E(5X) = 5 E(X)'),
          SizedBox(height: space),
          ebookTextWithTab(
              '3.   E(aX±b) = E(aX) ± E(b) = aE(X) ± b  เช่น  E(5X±3) = 5E(X) ± 3'),
          SizedBox(height: space),
          spanText([
            ebookTextSpan('นิยาม 2.4.3', 'bold'),
            ebookTextSpan('  E[u(x)] = ∑ u(x)f(x)', 'regular')
          ]),
          SizedBox(height: space),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ebookText('เช่น กำหนดให้   '),
                ebookMath(r"u(x) = X^2 ; E(X^2) = \sum{X^2f(x)}"),
              ],
            ),
          ),
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=52R9V6Qvl0A',
      music_url: 'https://www.youtube.com/watch?v=jfKfPfyJRdk',
      quiz: [2, 'Random Variable']),
  EBookPage(
      unit: 2,
      page: 6,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          spanText([
            ebookTextSpan('นิยามที่ 2.4.4', 'bold'),
            ebookTextSpan(
                '  ตัวแปรสุ่มที่มีการแจกแจงความน่าจะเป็นร่วมกัน X และ Y ',
                'regular')
          ]),
          SizedBox(height: space),
          ebookTextWithTab('  E(XY) = ∑∑XY f(x,y)'),
          SizedBox(height: space),
          ebookTextWithTab('  E(X)   = ∑∑X f(x,y)'),
          SizedBox(height: space),
          ebookTextWithTab('  E(Y)   = ∑∑Y f(x,y)'),
          SizedBox(height: space),
          spanText([
            ebookTextSpan('นิยามที่ 2.4.5', 'bold'),
            ebookTextSpan('  กรณีตัวแปรสุ่ม X และ Y เป็นอิสระ จะได้', 'regular')
          ]),
          SizedBox(height: space),
          ebookTextWithTab('  E(XY) = E(X)E(Y)'),
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=52R9V6Qvl0A',
      music_url: 'https://www.youtube.com/watch?v=XstikgbeTPI',
      quiz: [2, 'Random Variable']),
  EBookPage(
      unit: 2,
      page: 7,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ebookTextHead1('2.5	โมเมนต์ของตัวแปรสุ่ม'),
          SizedBox(height: space),
          spanText([
            ebookTextSpan('นิยามที่ 2.5.1', 'bold'),
            ebookTextSpan(
                '  โมเมนต์ที่ 1 รอบจุดกำเนิดหรือ E(X) โมเมนต์ที่ 2 รอบค่าเฉลี่ยความแปรปรวน หรือ V(X)',
                'regular')
          ]),
          SizedBox(height: space),
          spanText([
            ebookTextSpan('นิยามที่ 2.5.2', 'bold'),
            ebookTextSpan(
                '  ถ้า X เป็นตัวแปรสุ่ม ความแปรปรวนของ X เขียนแทนด้วยสัญลักษณ์ V(X)',
                'regular')
          ]),
          SizedBox(height: space),
          ebookMath(r"V(X) = E(X-\mu)^2 = E(X^2)-{\mu}^2 = E(X^2)-E(X^2)"),
          SizedBox(height: space),
          ebookText('บทพิสูจน์'),
          SizedBox(height: space),
          ebookMath(r"E(X-\mu)^2 = E(X^2-2X\mu+{\mu}^2)"),
          SizedBox(height: space),
          ebookMath(r"E(X-\mu)^2 = E(X^2)-2{\mu}E(X)+E({\mu}^2)"),
          SizedBox(height: space),
          ebookMath(r"E(X-\mu)^2 = E(X^2)-2{\mu}^2+{\mu}^2"),
          SizedBox(height: space),
          ebookMath(r"E(X-\mu)^2 = E(X^2)-{\mu}^2"),
          SizedBox(height: space),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ebookTextBold('หมายเหตุ  :  '),
                ebookText('ส่วนเบี่ยงเบนมาตรฐาน     '),
                ebookMath(r"\sigma = \sqrt{V(X)}")
              ],
            ),
          )
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=52R9V6Qvl0A',
      music_url: 'https://www.youtube.com/watch?v=7JPTlqRRf1w',
      quiz: [2, 'Random Variable']),
  EBookPage(
      unit: 2,
      page: 8,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ebookTextBold('คุณสมบัติของความแปรปรวน'),
          SizedBox(height: space),
          Row(
            children: [
              ebookMath(r"V(c) = 0"),
              ebookText('   เช่น   '),
              ebookMath(r"V(5) = 0"),
            ],
          ),
          SizedBox(height: space),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ebookMath(r"V(cX) = c^2V(X)"),
                ebookText('   เช่น   '),
                ebookMath(r"V(5X) = 25V(X)"),
              ],
            ),
          ),
          SizedBox(height: space),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ebookMath(r"V(cX{\pm}b) = c^2V(X)"),
                ebookText('   เช่น   '),
                ebookMath(r"V(5X-10) = 25V(X)"),
              ],
            ),
          ),
          SizedBox(height: space),
          ebookTextBold('แนวทางการพิสูจน์คุณสมบัติของความแปรปรวน'),
          SizedBox(height: space),
          Row(
            children: [
              ebookTextBold('คุณสมบัติข้อที่ 1   '),
              ebookMath(r"V(c) = 0"),
            ],
          ),
          SizedBox(height: space),
          ebookMath(r"V(a) = E[a-E(a)]^2"),
          SizedBox(height: space),
          ebookMath(r"V(a) = E(a-a)^2"),
          SizedBox(height: space),
          ebookMath(r"V(a) = E(0)"),
          SizedBox(height: space),
          ebookMath(r"V(a) = 0"),
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=wkrTm2QAvR0',
      music_url: 'https://www.youtube.com/watch?v=rFJol2pYlEo',
      quiz: [2, 'Random Variable']),
  EBookPage(
      unit: 2,
      page: 9,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              ebookTextBold('คุณสมบัติข้อที่ 2   '),
              ebookMath(r"V(cX) = c^2V(X)"),
            ],
          ),
          SizedBox(height: space),
          ebookMath(r"V(cX) = E[cX-E(cX)]^2"),
          SizedBox(height: space),
          ebookMath(r"V(cX) = E[cX-cE(X)]^2"),
          SizedBox(height: space),
          ebookMath(r"V(cX) = E[c(X-E(X))]^2"),
          SizedBox(height: space),
          ebookMath(r"V(cX) = c^2E(X-E(X))^2"),
          SizedBox(height: space),
          Row(
            children: [
              ebookTextBold('คุณสมบัติข้อที่ 3   '),
              ebookMath(r"V(cX{\pm}b) = c^2V(X)"),
            ],
          ),
          SizedBox(height: space),
          ebookMath(r"V(X+c) = E[(X+c)-E(X+c)]^2"),
          SizedBox(height: space),
          ebookMath(r"V(X+c) = E[(X+c-E(X)-c]^2"),
          SizedBox(height: space),
          ebookMath(r"V(X+c) = E[X-E(X)]^2"),
          SizedBox(height: space),
          ebookMath(r"V(X+c) = V(X)"),
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=wkrTm2QAvR0',
      music_url: 'https://www.youtube.com/watch?v=r8hjfGhwK-c',
      quiz: [2, 'Random Variable']),
  EBookPage(
      unit: 2,
      page: 10,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ebookTextHead1('2.6    ความแปรปรวนร่วมของตัวแปรสุ่ม X และ Y '),
          SizedBox(height: space),
          spanText([
            ebookTextSpan('นิยามที่ 2.6.1', 'bold'),
            ebookTextSpan(
                '  ในบางครั้ง ตัวแปรสุ่ม X และ Y มีฟังก์ชันความน่าจะเป็นร่วมกัน (Covariance) ค่าความแปรปรวนร่วมกันของตัวแปรสุ่ม เขียนแทนด้วย Cov(X,y)  คือ',
                'regular')
          ]),
          SizedBox(height: space),
          ebookMath(
              r"""\sigma_{XY} = E[(X-\mu_X)(Y-\mu_Y)] = E(XY)-\mu_X\mu_Y = E(XY)-E(X)E(Y)"""),
          SizedBox(height: space),
          ebookTextBold('พิสูจน์'),
          SizedBox(height: space),
          ebookMath(r"\sigma_{XY} = E[(X-\mu_X)(Y-\mu_Y)]"),
          SizedBox(height: space),
          ebookMath(r"\sigma_{XY} = E(XY-X\mu_Y-Y\mu_X+\mu_X\mu_Y)"),
          SizedBox(height: space),
          ebookMath(r"\sigma_{XY} = E(XY)-\mu_YE(X)-\mu_XE(Y)+\mu_X\mu_Y"),
          SizedBox(height: space),
          ebookMath(r"\sigma_{XY} = E(XY)-E(Y)E(X)-E(X)E(Y)+E(X)E(Y)"),
          SizedBox(height: space),
          ebookMath(r"\sigma_{XY} = E(XY)-E(X)E(Y)"),
          SizedBox(height: space),
          spanText([
            ebookTextSpan('นิยามที่ 2.6.2', 'bold'),
            ebookTextSpan(
                '  คุณสมบัติของความแปรปรวน ในกรณี X และ Y เป็นตัวแปรสุ่ม ซึ่งมีฟังก์ชันความน่าจะเป็นร่วมกัน   f(x,y)',
                'regular')
          ]),
          SizedBox(height: space),
          ebookMath(
              r"1. \sigma_{aX+bY}^2 = a^2\sigma_X^2+b^2\sigma_Y^2+2ab\sigma_{XY}"),
          SizedBox(height: space),
          ebookMath(
              r"2. \sigma_{aX-bY}^2 = a^2\sigma_X^2+b^2\sigma_Y^2-2ab\sigma_{XY}"),
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=wkrTm2QAvR0',
      music_url: 'https://www.youtube.com/watch?v=jwjRGZp_Xxg',
      quiz: [2, 'Random Variable']),
  EBookPage(
      unit: 2,
      page: 11,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ebookTextBold('แนวทางการพิสูจน์'),
          SizedBox(height: space),
          Row(
            children: [
              ebookTextBold('กรณี   '),
              ebookMath(
                  r"\sigma_{aX-bY}^2 = a^2\sigma_X^2+b^2\sigma_Y^2-2ab\sigma_{XY}"),
            ],
          ),
          SizedBox(height: space),
          Row(
            children: [
              ebookTextBold('จากนิยามที่ 2.5.2  '),
              ebookMath(r"\sigma_{X}^2 = E[X-E(X)]^2"),
            ],
          ),
          SizedBox(height: space),
          ebookMath(r"\sigma_{aX-bY}^2 = E[(aX-bY)-E(aX-bY)]^2"),
          SizedBox(height: space),
          ebookMath(r"\sigma_{aX-bY}^2 = E[(aX-bY)-(aE(X)-bE(Y))]^2"),
          SizedBox(height: space),
          ebookMath(r"\sigma_{aX-bY}^2 = E[(aX-bY)-(a\mu_X-b\mu_Y)]^2"),
          SizedBox(height: space),
          ebookMath(r"\sigma_{aX-bY}^2 = E[a(X-\mu_X)-b(Y-\mu_Y)]^2"),
          SizedBox(height: space),
          ebookMath(
              r"\sigma_{aX-bY}^2 = E(a^2-\mu_X)^2+b^2(Y-\mu_Y)^2-2ab(X-\mu_X)(Y-\mu_Y)"),
          SizedBox(height: space),
          ebookMath(
              r"\sigma_{aX-bY}^2 = a^2E(X-\mu_X)^2+b^2E(Y-\mu_Y)^2-2abE[(X-\mu_X)(Y-\mu_Y)]"),
          SizedBox(height: space),
          ebookMath(
              r"\sigma_{aX-bY}^2 = a^2\sigma_X^2+b^2\sigma_Y^2-2ab\sigma_{XY}"),
          SizedBox(height: space),
          spanText([
            ebookTextSpan('นิยามที่ 2.6.3', 'bold'),
            ebookTextSpan('  กรณี X และ Y เป็นตัวแปรสุ่มซึ่งเป็นอิสระกัน จะได้',
                'regular')
          ]),
          SizedBox(height: space),
          ebookMath(r"\sigma_{aX{\pm}bY}^2 = a^2\sigma_X^2+b^2\sigma_Y^2"),
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=wkrTm2QAvR0',
      music_url: 'https://www.youtube.com/watch?v=GSdYPkgCvtE&t=127s',
      quiz: [2, 'Random Variable']),
];

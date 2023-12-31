import 'package:flutter/material.dart';
import 'package:statweb/states/eBook/eBook_class.dart';
import 'package:statweb/states/eBook/eBook_constant.dart';

// double widhtUI = MediaQuery.of(context).size.width;
double space = 20;
double pictureH = 160;

List<EBookPage> ebookU1 = [

  EBookPage(
 
      unit: 1,
      page: 1,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ebookTextWithTab(
              'การหาค่าความน่าจะเป็น เป็นการหาโอกาสที่จะเกิดเหตุการณ์ว่ามีโอกาสเกิดมากน้อยเพียงใด โดยทั่วไปจําแนกได้ 3 วิธี ดังนี้'),
          SizedBox(height: space),
          ebookTextWithTab(
              '1. วิธีคลาสสิก (Classical Method) เป็นวิธีที่ใช้หลักการและเหตุผลในการคํานวณ หาค่าความน่าจะเป็น โดยการหาจํานวนเหตุการณ์ที่สนใจ (Event: E) หารด้วยจํานวนผลลัพธ์ ที่เป็นไปได้ทั้งหมด (Sample Space: S) หรือ P(E) : = n(E) / n(S)'),
          SizedBox(height: space),
          ebookTextWithTab(
              '2. วิธีใช้ความถี่สัมพัทธ์ (Relative Frequency Method) เป็นวิธีที่ใช้การทดลอง เช่น ต้องการทราบค่าความน่าจะเป็นของการออกหัว จากการโยนเหรียญที่เที่ยงตรง 1 ครั้ง วิธีการ คือ นําเหรียญที่เที่ยงตรงทดลองโยน 100 ครั้ง แล้วทำการจดบันทึกจํานวนหน้าหัวที่ปรากฏ สมมติว่า ออกหัวจํานวน 49 ครั้ง จะสรุปว่าความน่าจะเป็นที่เหรียญจะออกหัวมีความน่าจะเป็นเท่ากับ 49/100  = 0.49'),
          SizedBox(height: space),
          ebookTextWithTab(
              '3. วิธีจิตวิสัย (Subject Method) เป็นวิธีที่ใช้ประสบการณ์หรือความเชี่ยวชาญส่วนบุคคล ซึ่งประสบการณ์หรือความชํานาญของแต่ละบุคคลย่อมต่างกัน'),
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=fvVTr9u5Tto',
      music_url: 'https://www.youtube.com/watch?v=wygy721nzRc&t=69s',
      quiz: [1, 'Probability']),
  EBookPage(
      unit: 1,
      page: 2,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ebookTextHead1('1.1 คุณสมบัติของความน่าจะเป็น'),
          SizedBox(height: space),
          ebookText('คุณสมบัติของความน่าจะเป็น ถ้ากำหนดให้ P(E) = n(E) / n(S)'),
          SizedBox(height: space),
          ebookTextWithTab('P(E) คือ ความน่าจะเป็นของการเกิดเหตุการณ์ใด ๆ'),
          ebookTextWithTab('n(E) คือ จํานวนเหตุการณ์ใด ๆ ที่สนใจ'),
          ebookTextWithTab('n(S) คือ จํานวนเหตุการณ์ที่เป็นไปได้ทั้งหมด '),
          SizedBox(height: space),
          ebookText('คุณสมบัติของความน่าจะเป็น แสดงได้ดังนี้'),
          SizedBox(height: space),
          ebookTextWithTab('1. P(E) ≥ 0'),
          ebookTextWithTab(
              '2. P(S) = 1 เมื่อ P(S) คือ ความน่าจะเป็นของการเกิดเหตุการณ์ที่เป็นไปได้ทั้งหมด'),
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=fvVTr9u5Tto',
      music_url: 'https://www.youtube.com/watch?v=3ZltabzNSDs',
      quiz: [1, 'Probability']),
  EBookPage(
      unit: 1,
      page: 3,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ebookTextHead1('1.2 กฎและทฤษฎีที่สำคัญบางประการของความน่าจะเป็น'),
          SizedBox(height: space),
          spanText([
            ebookTextSpan('ทฤษฎีที่ 1.1', 'bold'),
            ebookTextSpan(
                '  ถ้า A และ B เป็นเหตุการณ์ใด ๆ ใน S แล้ว ความน่าจะเป็นของเหตุการณ์ A หรือ เหตุการณ์ B คือ P(A ∪ B) จะได้ P(A ∪ B) = P(A)+P(B) - P(A ∩ B)',
                'regular')
          ]),
          SizedBox(height: space),
          ebookImage('ebooks%2F1_1.png?alt=media&token=719058fa-0a85-4923-8fb5-860d94898afd', pictureH),
          SizedBox(height: space),
          ebookText(
              'ในกรณี A กับ B เป็นเหตุการณ์ที่ไม่เกิดร่วมกัน (Mutually Exclusive) จะได้ P(A ∪ B) = P(A) + P(B)'),
          SizedBox(height: space),
          ebookImage('ebooks%2F1_2.png?alt=media&token=d86fa830-b607-402d-a0da-0ce21bdeb689', pictureH),
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=fvVTr9u5Tto',
      music_url: 'https://www.youtube.com/watch?v=3jWRrafhO7M&t=207s',
      quiz: [1, 'Probability']),
  EBookPage(
      unit: 1,
      page: 4,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ebookText(
              'ในกรณีที่มี 3 เหตุการณ์ ใด ๆ ใน S จะได้ P (A ∪ B ∪ C) = P(A) + P(B) + P(C) - P(A ∩ B) - P(A ∩ C) - P(B ∩ C) + P(A ∩ B ∩ C) '),
          SizedBox(height: space),
          ebookImage('ebooks%2F1_3.png?alt=media&token=51237fde-83fe-4809-b155-4058a47ebf9b', pictureH),
          SizedBox(height: space),
          ebookText(
              'ส่วนกรณี A, B และ C เป็นเหตุการณ์ที่ไม่เกิดร่วมกัน จะได้ P(A ∪ B ∪ C) = P(A) + P(B) + P(C) '),
          SizedBox(height: space),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ebookTextWithTab('P (A ∩ B ∩ C) = 0'),
                  ebookTextWithTab('P (A ∩ B)       = 0'),
                  ebookTextWithTab('P (B ∩ C)       = 0'),
                  ebookTextWithTab('P (A ∩ C)       = 0'),
                ],
              ),
              Expanded(child: ebookImage('ebooks%2F1_4.png?alt=media&token=14bcc77d-14d1-4f0d-bc89-954503ad7162', pictureH)),
            ],
          ),
          SizedBox(height: space),
          spanText([
            ebookTextSpan('หมายเหตุ', 'bold'),
            ebookTextSpan(
                ' : A ∪ B ตรงกับภาษาไทย คือ เหตุการณ์ A หรือ เหตุการณ์ B หมายถึง มีการเกิด เหตุการณ์อย่างน้อย 1 เหตุการณ์ คือ เกิดเหตุการณ์ A อย่างเดียว หรือเกิดเหตุการณ์ B อย่างเดียว หรือเกิดทั้งเหตุการณ์ A และ B',
                'regular')
          ]),
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=fvVTr9u5Tto',
      music_url: 'https://www.youtube.com/watch?v=UoSo95YcPUk',
      quiz: [1, 'Probability']),
  EBookPage(
      unit: 1,
      page: 5,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          spanText([
            ebookTextSpan('ทฤษฎีที่ 1.2', 'bold'),
            ebookTextSpan(
                "  ถ้า A' เป็นคอมพลีเมนต์ของเหตุการณ์ A แล้ว P(A') = 1 – P(A) เช่น ถ้า P(A) = 0.6 จะได้         P(A') = 0.4 หรือ P(B) = 0.05 จะได้ P(B') = 0.95 เป็นต้น",
                'regular')
          ]),
          SizedBox(height: space),
          ebookTextWithTab(
              "การแปลงรูปสัญลักษณ์ของเหตุการณ์บางเหตุการณ์ที่มีคอมพลีเมนต์ สามารถทำการแปลงรูปได้ ดังนี้ความน่าจะเป็นของเหตุการณ์ A แต่ไม่เกิดเหตุการณ์ B เขียนแทนด้วยสัญลักษณ์ P(A ∩ B')สามารถแปลงรูปได้เป็น P(A) - P(A ∩ B) "),
          SizedBox(height: space),
          ebookImage('ebooks%2F1_5.png?alt=media&token=5a8701a7-de46-4130-b5dd-18ea534236be', pictureH),
          SizedBox(height: space),
          ebookTextWithTab(
              "ความน่าจะเป็นของเหตุการณ์ B แต่ไม่เกิดเหตุการณ์ A เขียนแทนด้วยสัญลักษณ์ P(A' ∩ B) สามารถแปลงรูปได้เป็น P(B) - P(A ∩ B) "),
          SizedBox(height: space),
          ebookImage('ebooks%2F1_6.png?alt=media&token=029dbaf8-0081-4196-9521-b4e3aa7d48dd', pictureH),
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=fvVTr9u5Tto',
      music_url: 'https://www.youtube.com/watch?v=2Me0j8HwA2Y',
      quiz: [1, 'Probability']),
  EBookPage(
      unit: 1,
      page: 6,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ebookTextWithTab(
              "ความน่าจะเป็นของการไม่เกิดเหตุการณ์ A และไม่เกิดเหตุการณ์ B เขียนแทนด้วยสัญลักษณ์ P(A' ∩ B')   สามารถแปลงรูปได้เป็น 1 - P(A ∪ B) "),
          SizedBox(height: space),
          ebookImage('ebooks%2F1_7.png?alt=media&token=18f9201f-9f1d-419a-9dee-68f655694a1a', pictureH),
          SizedBox(height: space),
          ebookTextWithTab(
              "ความน่าจะเป็นของการไม่เกิดเหตุการณ์ A หรือไม่เกิดเหตุการณ์ B เขียนแทนด้วยสัญลักษณ์ P(A' ∪ B') สามารถแปลงรูปได้เป็น 1 - P(A ∩ B) "),
          SizedBox(height: space),
          ebookImage('ebooks%2F1_8.png?alt=media&token=3cfafe3e-0dc9-4e95-abae-c61a803df65f', pictureH),
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=_KW8jh99G08',
      music_url: 'https://www.youtube.com/watch?v=iakmEG8u7B0',
      quiz: [1, 'Probability']),
  EBookPage(
      unit: 1,
      page: 7,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ebookTextHead1("1.3 ความน่าจะเป็นแบบมีเงื่อนไข"),
          SizedBox(height: space),
          ebookTextWithTab(
              "ความน่าจะเป็นแบบมีเงื่อนไข (Conditional Probability) เป็นการหาความน่าจะเป็นของ เหตุการณ์ A เมื่อกำหนดว่า เหตุการณ์ B ได้เกิดขึ้นแล้ว"),
          SizedBox(height: space),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ebookTextBold("ทฤษฎีที่ 1.3    "),
                ebookMath(r'P(A|B) = \frac {P(A{\cap}B)} {P(B)}  ,  P(B) \gt 0'),
              ],
            ),
          ),
          SizedBox(height: space),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ebookText("ในทำนองเดียวกัน   "),
                ebookMath(r'P(B|A) = \frac {P(A{\cap}B)} {P(A)}  ,  P(A) \gt 0'),
              ],
            ),
          ),
          SizedBox(height: space),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ebookText("บทแทรกที่ 1.3.1   "),
                ebookMath(
                    r"P(A'|B) = \frac {P(A'{\cap}B)} {P(B)}  ,  P(B) \gt 0"),
              ],
            ),
          ),
          SizedBox(height: space),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ebookText("บทแทรกที่ 1.3.2   "),
                ebookMath(
                    r"P(A|B') = \frac {P(A{\cap}B')} {P(B')}  ,  P(B') \gt 0"),
              ],
            ),
          ),
          SizedBox(height: space),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ebookText("บทแทรกที่ 1.3.3   "),
                ebookMath(
                    r"P(A'|B') = \frac {P(A'{\cap}B')} {P(B')}  ,  P(B') \gt 0"),
              ],
            ),
          ),
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=_KW8jh99G08',
      music_url: 'https://www.youtube.com/watch?v=EAP7j3B_yIY',
      quiz: [1, 'Probability']),
  EBookPage(
      unit: 1,
      page: 8,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ebookTextHead1("1.4 ทฤษฎีการคูณความน่าจะเป็น"),
          SizedBox(height: space),
          ebookText(
              "ทฤษฎีที่ 1.4 	การคูณความน่าจะเป็น P(A ∩ B) = P(A) P(B | A) กรณีมี 3 เหตุการณ์ A B และ C ใด ๆ P(A ∩ B ∩ C) = P(A) P(B | A) P(C | A ∩ B)"),
          SizedBox(height: space),
          ebookTextWithTab(
              "หมายความว่า ความน่าจะเป็นในการเกิดเหตุการณ์ A และ B และ C จะเท่ากับ ความน่าจะเป็นของเหตุการณ์ A คูณกับ ความน่าจะเป็นของเหตุการณ์ B เมื่อ เหตุการณ์ A ได้เกิดขึ้นแล้ว คูณกับ ความน่าจะเป็นของเหตุการณ์ C เมื่อเหตุการณ์ A และ B ได้เกิดขึ้นแล้ว"),
          SizedBox(height: space),
          ebookText(
              "ใทฤษฎีที่ 1.5 	กรณีที่เหตุการณ์เป็นอิสระกัน (Independent Event) จะทำให้ P(A ∩ B) = P(A) P(B)"),
          SizedBox(height: space),
          ebookTextWithTab(
              "ในทำนองเดียวกันถ้ามี 3 เหตุการณ์ จะทำให้ P(A ∩ B ∩ C) = P(A) P(B) P(C)"),
          SizedBox(height: space),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ebookTextWithTab("บทแทรกที่ 1.5.1   "),
                ebookMath(r"P(A'{\cap}B) = P(A')P(B)"),
              ],
            ),
          ),
          SizedBox(height: space),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ebookTextWithTab("บทแทรกที่ 1.5.2   "),
                ebookMath(r"P(A{\cap}B') = P(A)P(B')"),
              ],
            ),
          ),
          SizedBox(height: space),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ebookTextWithTab("บทแทรกที่ 1.5.3   "),
                ebookMath(r"P(A'{\cap}B') = P(A')P(B')"),
              ],
            ),
          ),
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=_KW8jh99G08',
      music_url: 'https://www.youtube.com/watch?v=9E6b3swbnWg',
      quiz: [1, 'Probability']),
  EBookPage(
      unit: 1,
      page: 9,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ebookTextWithTab(
              "กล่าวโดยสรุปกรณี A และ B เป็นเหตุการณ์ที่ไม่สามารถเกิดร่วมกันได้ จะทำให้เกิด P(A ∩ B) = 0 สำหรับในกรณี A และ B เป็นเหตุการณ์ที่เกิดร่วมกัน จะทำให้เกิด P(A ∩ B) = P(A) P(B | A) และเมื่อ A และ B เป็นเหตุการณ์ที่เป็นอิสระกัน P(A ∩ B) = P(A) P(B) "),
          SizedBox(height: space),
          Row(
            children: [
              Expanded(flex: 1, child: ebookImage('ebooks%2F1_11.png?alt=media&token=e5b5ab87-91d0-456e-802e-38de2d66382b', pictureH)),
              Expanded(
                child: ebookText(
                    "A และ B เป็นเหตุการณ์ที่ไม่สามารถเกิดร่วมกันได้"),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(flex: 1, child: ebookImage('ebooks%2F1_12.png?alt=media&token=0d3b7631-2b45-4ea7-80a8-c289279c324b', pictureH)),
              Expanded(child: ebookText("A และ B เป็นเหตุการณ์ที่เกิดร่วมกัน")),
            ],
          ),
          Row(
            children: [
              Expanded(flex: 1, child: ebookImage('ebooks%2F1_13.png?alt=media&token=098db5d9-73d8-45f6-9eca-b2cf4c48514c', pictureH)),
              Expanded(
                  child: ebookText("A และ B เป็นเหตุการณ์ที่เป็นอิสระกัน")),
            ],
          ),
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=_KW8jh99G08',
      music_url: 'https://www.youtube.com/watch?v=icZob9-1MDw',
      quiz: [1, 'Probability']),
  EBookPage(
      unit: 1,
      page: 10,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ebookTextHead1("1.5 กฎแห่งการรวมความน่าจะเป็น "),
          SizedBox(height: space),
          ebookImage('ebooks%2F1_14.png?alt=media&token=47f6c49b-10f8-4edc-9aaf-1ff10735cf5c', pictureH + 50),
          SizedBox(height: space),
          ebookText("จากรูป พบว่า P(D)=P(A ∩ D) + P(B ∩ D)"),
          SizedBox(height: space),
          ebookTextWithTab(
              "จากทฤษฎีที่ 1.4 การคูณความน่าจะเป็น P(A ∩ B)=P(A) P(B | A)"),
          SizedBox(height: space),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ebookTextWithTab("ดังนั้น "),
                ebookMath(r"P(D) = P(A)P(D|A)+P(B)P(D|B)"),
              ],
            ),
          ),
          SizedBox(height: space),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ebookTextWithTab("       "),
                ebookMath(r"P(D') = P(A{\cap}D')+P(B{\cap}D')"),
              ],
            ),
          ),
          SizedBox(height: space),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ebookTextWithTab("       "),
                ebookMath(r"P(D') = P(A)P(D'|A)+P(B)P(D'|B)"),
              ],
            ),
          ),
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=_KW8jh99G08',
      music_url: 'https://www.youtube.com/watch?v=JvNQLJ1_HQ0',
      quiz: [1, 'Probability']),
  EBookPage(
      unit: 1,
      page: 11,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ebookTextHead1("1.6 กฎของเบย์"),
          SizedBox(height: space),
          ebookTextWithTab(
              "กฎของเบย์ (Bayes' Rule) เป็นตัวอย่างการเขียนกฎของเบย์ด้วยแผนภาพต้นไม้"),
          SizedBox(height: space),
          ebookImage('ebooks%2F1_16.png?alt=media&token=ba359041-ab42-45fd-ac94-babe7bc35ef3', pictureH + 100),
          SizedBox(height: space),
          ebookTextWithTab(
              "สมมติว่าเลือกสินค้ามาชิ้นหนึ่งโดยการสุ่ม และพบว่าเป็นสินค้าดี (D) จงหาความน่าจะเป็น ที่สินค้าชิ้นนั้นมาจากเครื่องจักร B"),
          ebookTextWithTab(
              "นั่นคือ P(B|D)  = (P(B ∩ D))/(P(D) )    โดยที่ P(D) = P(A) P(D|A) + P(B) P(D|B)"),
          ebookTextWithTab(
              "ดังนั้น กฎของเบย์ หรือ  P(B|D)  = (P(B ∩ D))/(P(D) )  = (P(B) P(D|B))/(P(A) P(D|A) + P(B) P(D|B))"),
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=_KW8jh99G08',
      music_url: 'https://www.youtube.com/watch?v=fnA4HixjwqE',
      quiz: [1, 'Probability']),
  EBookPage(
      unit: 1,
      page: 12,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          spanText([
            ebookTextSpan('       หมายเหตุ : 	', 'bold'),
            ebookTextSpan(
                'กฎของเบย์ มีชื่อเรียกอีกชื่อหนึ่งว่า Posterior Probability ส่วน P(A) หรือ P(B) มีชื่อเรียกอีกอย่างหนึ่งว่า Prior Probability',
                'regular')
          ]),
          SizedBox(height: space),
          ebookTextWithTab(
              "ประโยชน์ของ กฎของเบย์ คือ ใช้เมื่อทราบผล D ของการทดลองแล้ว จะวิเคราะห์หาสาเหตุ หรือที่มาว่าผลของ D จะเกิดจากสาเหตุ A หรือ B ด้วยความน่าจะเป็นมากน้อยเพียงใด"),
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=_KW8jh99G08',
      music_url: 'https://www.youtube.com/watch?v=895MzDtil0M&t=2s',
      quiz: [1, 'Probability']),
];

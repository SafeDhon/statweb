import 'package:flutter/material.dart';
import 'package:statweb/states/eBook/eBook_class.dart';
import 'package:statweb/states/eBook/eBook_constant.dart';

List<EBookPage> ebookU1 = [
  EBookPage(
      unit: 1,
      page: 1,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ebookTextWithTab(
              'การหาค่าความน่าจะเป็น เป็นการหาโอกาสที่จะเกิดเหตุการณ์ว่ามีโอกาสเกิดมากน้อยเพียงใด โดยทั่วไปจําแนกได้ 3 วิธี ดังนี้'),
          ebookTextWithTab(
              '1. วิธีคลาสสิก (Classical Method) เป็นวิธีที่ใช้หลักการและเหตุผลในการคํานวณ หาค่าความน่าจะเป็น โดยการหาจํานวนเหตุการณ์ที่สนใจ (Event: E) หารด้วยจํานวนผลลัพธ์ ที่เป็นไปได้ทั้งหมด (Sample Space: S) หรือ P(E) : = n(E) / n(S)'),
          ebookTextWithTab(
              '2. วิธีใช้ความถี่สัมพัทธ์ (Relative Frequency Method) เป็นวิธีที่ใช้การทดลอง เช่น ต้องการทราบค่าความน่าจะเป็นของการออกหัว จากการโยนเหรียญที่เที่ยงตรง 1 ครั้ง วิธีการ คือ นําเหรียญที่เที่ยงตรงทดลองโยน 100 ครั้ง แล้วทำการจดบันทึกจํานวนหน้าหัวที่ปรากฏ สมมติว่า ออกหัวจํานวน 49 ครั้ง จะสรุปว่าความน่าจะเป็นที่เหรียญจะออกหัวมีความน่าจะเป็นเท่ากับ 49/100  = 0.49'),
          ebookTextWithTab(
              '3. วิธีจิตวิสัย (Subject Method) เป็นวิธีที่ใช้ประสบการณ์หรือความเชี่ยวชาญส่วนบุคคล ซึ่งประสบการณ์หรือความชํานาญของแต่ละบุคคลย่อมต่างกัน'),
        ],
      ),
      vdo_url: 'https://www.youtube.com/watch?v=LkwvF6OVhnk',
      music_url: 'https://www.youtube.com/watch?v=QJusTUOyahE',
      quiz: [1,'11111']),
  EBookPage(
      unit: 1,
      page: 2,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ebookTextHead1('1.1 คุณสมบัติของความน่าจะเป็น'),
          ebookText('คุณสมบัติของความน่าจะเป็น ถ้ากำหนดให้ P(E) = n(E) / n(S)'),
          ebookTextWithTab('P(E) คือ ความน่าจะเป็นของการเกิดเหตุการณ์ใด ๆ'),
          ebookTextWithTab('n(E) คือ จํานวนเหตุการณ์ใด ๆ ที่สนใจ'),
          ebookTextWithTab('n(S) คือ จํานวนเหตุการณ์ที่เป็นไปได้ทั้งหมด '),
          ebookText('คุณสมบัติของความน่าจะเป็น แสดงได้ดังนี้'),
          ebookTextWithTab('1. P(E) ≥ 0'),
          ebookTextWithTab(
              '2. P(S) = 1 เมื่อ P(S) คือ ความน่าจะเป็นของการเกิดเหตุการณ์ที่เป็นไปได้ทั้งหมด'),
        ],
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: [1,'222222']),
  EBookPage(
      unit: 1,
      page: 3,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ebookTextHead1('1.2 กฎและทฤษฎีที่สำคัญบางประการของความน่าจะเป็น'),
          ebookText(
              'ทฤษฎีที่ 1.1 ถ้า A และ B เป็นเหตุการณ์ใด ๆ ใน S แล้ว ความน่าจะเป็นของเหตุการณ์ A หรือ เหตุการณ์ B คือ P(A ∪ B) จะได้ P(A ∪ B) = P(A)+P(B) - P(A ∩ B)'),
          ebookText(
              'ในกรณี A กับ B เป็นเหตุการณ์ที่ไม่เกิดร่วมกัน (Mutually Exclusive) จะได้ P(A ∪ B) = P(A) + P(B)'),
          ebookText(
              'ในกรณีที่มี 3 เหตุการณ์ ใด ๆ ใน S จะได้ P (A ∪ B ∪ C) = P(A) + P(B) + P(C) - P(A ∩ B) - P(A ∩ C) - P(B ∩ C) + P(A ∩ B ∩ C) '),
        ],
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: [1,'']),
  EBookPage(
      unit: 1,
      page: 4,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ebookText(
              'ส่วนกรณี A, B และ C เป็นเหตุการณ์ที่ไม่เกิดร่วมกัน จะได้ P(A ∪ B ∪ C) = P(A) + P(B) + P(C) '),
          ebookTextWithTab('P (A ∩ B ∩ C) = 0'),
          ebookTextWithTab('P (A ∩ B)       = 0'),
          ebookTextWithTab('P (B ∩ C)       = 0'),
          ebookTextWithTab('P (A ∩ C)       = 0'),
          ebookText(
              'หมายเหตุ : A ∪ B ตรงกับภาษาไทย คือ เหตุการณ์ A หรือ เหตุการณ์ B หมายถึง มีการเกิด เหตุการณ์อย่างน้อย 1 เหตุการณ์ คือ เกิดเหตุการณ์ A อย่างเดียว หรือเกิดเหตุการณ์ B อย่างเดียว หรือเกิดทั้งเหตุการณ์ A และ B'),
        ],
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: [1,'']),
  EBookPage(
      unit: 1,
      page: 5,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ebookText(
              "ทฤษฎีที่ 1.2 ถ้า A' เป็นคอมพลีเมนต์ของเหตุการณ์ A แล้ว P(A') = 1 – P(A) เช่น ถ้า P(A) = 0.6 จะได้         P(A') = 0.4 หรือ P(B) = 0.05 จะได้ P(B') = 0.95 เป็นต้น"),
          ebookTextWithTab(
              "การแปลงรูปสัญลักษณ์ของเหตุการณ์บางเหตุการณ์ที่มีคอมพลีเมนต์ สามารถทำการแปลงรูปได้ ดังนี้ความน่าจะเป็นของเหตุการณ์ A แต่ไม่เกิดเหตุการณ์ B เขียนแทนด้วยสัญลักษณ์ P(A ∩ B')สามารถแปลงรูปได้เป็น P(A) - P(A ∩ B) "),
          ebookTextWithTab(
              "ความน่าจะเป็นของเหตุการณ์ B แต่ไม่เกิดเหตุการณ์ A เขียนแทนด้วยสัญลักษณ์ P(A' ∩ B) สามารถแปลงรูปได้เป็น P(B) - P(A ∩ B) "),
          ebookTextWithTab(
              "ความน่าจะเป็นของการไม่เกิดเหตุการณ์ A และไม่เกิดเหตุการณ์ B เขียนแทนด้วยสัญลักษณ์ P(A' ∩ B')   สามารถแปลงรูปได้เป็น 1 - P(A ∪ B) "),
        ],
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: [1,'']),
  EBookPage(
      unit: 1,
      page: 6,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ebookTextWithTab(
              "ความน่าจะเป็นของการไม่เกิดเหตุการณ์ A หรือไม่เกิดเหตุการณ์ B เขียนแทนด้วยสัญลักษณ์ P(A' ∪ B') สามารถแปลงรูปได้เป็น 1 - P(A ∩ B) "),
          ebookTextHead1("1.3 ความน่าจะเป็นแบบมีเงื่อนไข"),
          ebookTextWithTab(
              "ความน่าจะเป็นแบบมีเงื่อนไข (Conditional Probability) เป็นการหาความน่าจะเป็นของ เหตุการณ์ A เมื่อกำหนดว่า เหตุการณ์ B ได้เกิดขึ้นแล้ว"),
          ebookText(
              "ทฤษฎีที่ 1.3 	P(A | B) =   (P(A ∩ B))/(P(B) )    , P(B) > 0"),
          ebookText(
              "ในทำนองเดียวกัน P(B|A) =   (P(A ∩ B))/(P(A) )    , P(A) > 0 "),
          ebookText(
              "บทแทรกที่ 1.3.1 P(A' | B) =  (P(A' ∩ B))/(P(B) )    , P(B) > 0"),
          ebookText(
              "บทแทรกที่ 1.3.2 P(A | B') =  (P(A ∩ B'))/(P(B') )    , P(B') > 0"),
          ebookText(
              "บทแทรกที่ 1.3.3 P(A' | B') =  (P(A' ∩ B'))/(P(B') )    , P(B') > 0"),
        ],
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: [1,'']),
  EBookPage(
      unit: 1,
      page: 7,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ebookTextHead1("1.4 ทฤษฎีการคูณความน่าจะเป็น"),
          ebookText(
              "ทฤษฎีที่ 1.4 	การคูณความน่าจะเป็น P(A ∩ B) = P(A) P(B | A) กรณีมี 3 เหตุการณ์ A B และ C ใด ๆ P(A ∩ B ∩ C) = P(A) P(B | A) P(C | A ∩ B)"),
          ebookTextWithTab(
              "หมายความว่า ความน่าจะเป็นในการเกิดเหตุการณ์ A และ B และ C จะเท่ากับ ความน่าจะเป็นของเหตุการณ์ A คูณกับ ความน่าจะเป็นของเหตุการณ์ B เมื่อ เหตุการณ์ A ได้เกิดขึ้นแล้ว คูณกับ ความน่าจะเป็นของเหตุการณ์ C เมื่อเหตุการณ์ A และ B ได้เกิดขึ้นแล้ว"),
          ebookText(
              "ใทฤษฎีที่ 1.5 	กรณีที่เหตุการณ์เป็นอิสระกัน (Independent Event) จะทำให้ P(A ∩ B) = P(A) P(B)"),
          ebookTextWithTab(
              "ในทำนองเดียวกันถ้ามี 3 เหตุการณ์ จะทำให้ P(A ∩ B ∩ C) = P(A) P(B) P(C)"),
          ebookTextWithTab("บทแทรกที่ 1.5.1 P(A' ∩ B) 	= 	P(A')P(B)"),
          ebookTextWithTab("บทแทรกที่ 1.5.2 P(A ∩ B') 	= 	P(A)P(B')"),
          ebookTextWithTab("บทแทรกที่ 1.5.3 P(A' ∩ B') 	= 	P(A')P(B')"),
        ],
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: [1,'']),
  EBookPage(
      unit: 1,
      page: 8,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ebookTextWithTab(
              "กล่าวโดยสรุปกรณี A และ B เป็นเหตุการณ์ที่ไม่สามารถเกิดร่วมกันได้ จะทำให้เกิด P(A ∩ B) = 0 สำหรับในกรณี A และ B เป็นเหตุการณ์ที่เกิดร่วมกัน จะทำให้เกิด P(A ∩ B) = P(A) P(B | A) และเมื่อ A และ B เป็นเหตุการณ์ที่เป็นอิสระกัน P(A ∩ B) = P(A) P(B) "),
          ebookTextWithTab("A และ B เป็นเหตุการณ์ที่ไม่สามารถเกิดร่วมกันได้"),
          ebookTextWithTab("A และ B เป็นเหตุการณ์ที่เกิดร่วมกัน"),
          ebookTextWithTab("A และ B เป็นเหตุการณ์ที่เป็นอิสระกัน"),
        ],
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: [1,'']),
  EBookPage(
      unit: 1,
      page: 9,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ebookTextHead1("1.5 กฎแห่งการรวมความน่าจะเป็น "),
          ebookText("จากรูป พบว่า P(D)=P(A ∩ D) + P(B ∩ D)"),
          ebookTextWithTab(
              "จากทฤษฎีที่ 1.4 การคูณความน่าจะเป็น P(A ∩ B)=P(A) P(B | A)"),
          ebookTextWithTab("ดังนั้น			P(D) = P(A) P(D | A) + P(B) P(D | B)"),
          ebookTextWithTab("         P(D') = P(A ∩ D') + P(B ∩ D')"),
          ebookTextWithTab("         P(D') = P(A) P(D' | A) + P(B) P(D' | B)"),
        ],
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: [1,'']),
  EBookPage(
      unit: 1,
      page: 10,
      contain: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ebookTextHead1("1.6 กฎของเบย์"),
          ebookTextWithTab(
              "กฎของเบย์ (Bayes' Rule) เป็นตัวอย่างการเขียนกฎของเบย์ด้วยแผนภาพต้นไม้"),
          ebookTextWithTab(
              "สมมติว่าเลือกสินค้ามาชิ้นหนึ่งโดยการสุ่ม และพบว่าเป็นสินค้าดี (D) จงหาความน่าจะเป็น ที่สินค้าชิ้นนั้นมาจากเครื่องจักร B"),
          ebookTextWithTab(
              "นั่นคือ P(B|D)  = (P(B ∩ D))/(P(D) )    โดยที่ P(D) = P(A) P(D|A) + P(B) P(D|B)"),
          ebookTextWithTab(
              "ดังนั้น กฎของเบย์ หรือ  P(B|D)  = (P(B ∩ D))/(P(D) )  = (P(B) P(D|B))/(P(A) P(D|A) + P(B) P(D|B))"),
          ebookTextWithTab(
              "หมายเหตุ : 	กฎของเบย์ มีชื่อเรียกอีกชื่อหนึ่งว่า Posterior Probability ส่วน P(A) หรือ P(B) มีชื่อเรียกอีกอย่างหนึ่งว่า Prior Probability"),
          ebookTextWithTab(
              "ประโยชน์ของ กฎของเบย์ คือ ใช้เมื่อทราบผล D ของการทดลองแล้ว จะวิเคราะห์หาสาเหตุ หรือที่มาว่าผลของ D จะเกิดจากสาเหตุ A หรือ B ด้วยความน่าจะเป็นมากน้อยเพียงใด"),
        ],
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: [1,'']),
];

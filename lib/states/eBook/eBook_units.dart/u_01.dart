import 'package:flutter/material.dart';
import 'package:statweb/responsive/test_responsive.dart';
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
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: Container()),
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
      quiz: Container()),
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
          ebookTextWithTab('n(S) คือ จํานวนเหตุการณ์ที่เป็นไปได้ทั้งหมด '),
          ebookText('คุณสมบัติของความน่าจะเป็น แสดงได้ดังนี้'),
          ebookTextWithTab('1. P(E) ≥ 0'),
          ebookTextWithTab(
              '2. P(S) = 1 เมื่อ P(S) คือ ความน่าจะเป็นของการเกิดเหตุการณ์ที่เป็นไปได้ทั้งหมด'),
        ],
      ),
      vdo_url: 'vdo_url',
      music_url: 'music_url',
      quiz: Container()),
];

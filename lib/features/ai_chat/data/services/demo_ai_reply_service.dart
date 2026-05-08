class DemoAiReplyService {
  const DemoAiReplyService();

  String generateReply(String text) {
    final lower = text.toLowerCase();

    if (lower.contains('korea') ||
        lower.contains('koreya') ||
        lower.contains('zavod')) {
      return 'Sizga Koreyada zavod ishlariga mos vakansiyalar topdim:\n\n1. Factory Worker вЂ” \$2200\n2. Packing Worker вЂ” \$2000\n3. Warehouse Assistant вЂ” \$2100\n\nUy-joy va viza yordami bor.';
    }

    if (lower.contains('it') ||
        lower.contains('remote') ||
        lower.contains('flutter')) {
      return 'Sizga IT va remote ishlar mos keladi:\n\n1. Flutter Developer вЂ” \$3500\n2. UI/UX Designer вЂ” \$2800\n3. Frontend Developer вЂ” \$3200\n\nProfilingizni toвЂldirsangiz AI match foizini ham chiqaramiz.';
    }

    if (lower.contains('toshkent')) {
      return 'Toshkent boвЂyicha topilgan ishlar:\n\n1. Sales Manager вЂ” 8 mln soвЂm\n2. Operator вЂ” 5 mln soвЂm\n3. Courier вЂ” 7 mln soвЂm\n\nQaysi soha sizga qiziq?';
    }

    return 'Tushundim. Sizga mos ish topishim uchun 3 ta narsani ayting:\n\n1. Qaysi sohada ishlamoqchisiz?\n2. Qancha maosh kutyapsiz?\n3. Qaysi shahar yoki davlat kerak?';
  }
}

import 'package:flutter/material.dart';

void main() => runApp(const JokerApp());

class JokerApp extends StatelessWidget {
  const JokerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'جوكر التقارير الجامعية',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorSchemeSeed: Colors.indigo,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('جوكر التقارير الجامعية'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    children: [
                      const Icon(Icons.description_outlined, size: 64),
                      const SizedBox(height: 12),
                      const Text(
                        'منشئ التقارير الجامعية',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'أنشئ تقريرك، نسّقه، ثم صدّره بصيغة PDF أو Word.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 22),
                      FilledButton.icon(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ReportPage()),
                        ),
                        icon: const Icon(Icons.add),
                        label: const Text('إنشاء تقرير جديد'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const ListTile(
                leading: Icon(Icons.phone_android),
                title: Text('متعدد المنصات'),
                subtitle: Text('مصمم ليعمل على Android وWindows بنفس المشروع'),
              ),
              const ListTile(
                leading: Icon(Icons.auto_awesome),
                title: Text('قالب جامعي'),
                subtitle: Text('يمكن تخصيص الغلاف والتنسيق حسب نموذج جامعتك'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final university = TextEditingController();
  final college = TextEditingController();
  final department = TextEditingController();
  final title = TextEditingController();
  final student = TextEditingController();
  final stage = TextEditingController();
  final content = TextEditingController();

  @override
  void dispose() {
    for (final c in [university, college, department, title, student, stage, content]) {
      c.dispose();
    }
    super.dispose();
  }

  Widget field(String label, TextEditingController c, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('تقرير جديد')),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            const Text('بيانات الغلاف',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),
            field('اسم الجامعة', university),
            field('الكلية / المعهد', college),
            field('القسم', department),
            field('عنوان التقرير', title),
            field('اسم الطالب', student),
            field('المرحلة', stage),
            const SizedBox(height: 8),
            const Text('محتوى التقرير',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            field('اكتب التقرير هنا...', content, maxLines: 14),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('معاينة التقرير'),
                    content: SingleChildScrollView(
                      child: Text(
                        '${university.text}\n${college.text}\n${department.text}\n\n'
                        '${title.text}\n\nالطالب: ${student.text}\nالمرحلة: ${stage.text}\n\n'
                        '${content.text}',
                        textAlign: TextAlign.right,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('إغلاق'),
                      )
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.preview),
              label: const Text('معاينة التقرير'),
            ),
          ],
        ),
      ),
    );
  }
}

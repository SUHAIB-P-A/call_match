import 'package:call_match/data/agentlist/data.dart';
import 'package:call_match/presentation/agent_ui/main_home.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  final String termsEnglish = '''
Conditions You Must Meet at Work
I. Cash Transactions and Customer Interactions
DO not engage in any cash transactions With
customers, accept gifts from them, or meet them
outside Of work. Violation Of this rule Will result in
termination.
II. Leave Policy
- You are allowed 4 leaves per month.
- Additional leave is granted only for emergencies.
- You must notify your supervisor the day before
taking leave.
- Immediate leave will only be granted for urgent
matters.
Ill. Work Hours
- Update your start time to IO am each day.
- You may make changes to the updated timings
from the previous day if necessary.
IV. Payment Method
— You must have a Google pay or PhonePe account,
as your salary will be sent to it.
Note: Compliance with these conditions is
mandatory for all employees.
''';

  final String termsMalayalam = '''
ജോലിയിൽ നിങ്ങൾ പാലിക്കേണ്ട നിബന്ധനകൾ
1. കസ്റ്റമറുമായി യാതൊരു രീതിയിലുള്ള പണമിടപാടുകൾ ഉണ്ടാക്കുകയോ, അവരുടെ കയ്യിൽ നിന്നും ഗിഫ്റ്റുകൾ വാങ്ങുകയോ, അവരെ മീറ്റ് ചെയ്യുകയോ, ചെയ്യുവാൻ പാടുള്ളതല്ല. അങ്ങനെ എന്തെങ്കിലും ശ്രദ്ധയിൽപ്പെട്ടാൽ അവരെ ജോലിയിൽ തുടരാൻ അനുവദിക്കുന്നതല്ല.
II. മാസത്തിൽ 4 ലീവ് ആണ് അനുവദിച്ചിട്ടുള്ളത്. എമർജൻസി കാര്യങ്ങൾക്കു മാത്രമാണ് കൂടുതൽ ലീവ് എടുക്കുവാൻ അനുവദമുള്ളത്.
ലീവ് ആവശ്യമുള്ളവർ തലേ ദിവസം അറിയിക്കേണ്ടതാണ്. അതല്ലാതെ എമർജൻസി കാര്യങ്ങൾക്കു മാത്രമായിരിക്കും പെട്ടെന്നുള്ള ലീവ് അനുവദിക്കുന്നത്.
III. നിങ്ങൾ ജോലിയിൽ പ്രവേശിക്കുന്ന സമയം അപ്ഡേറ്റ് ചെയ്യണ്ടത് തലേ ദിവസം മുതൽ അന്നേ ദിവസം രാവിലെ 10 മണി വരെയാണ്.
IV. തലേ ദിവസം അപ്ഡേറ്റ് ചെയ്‌ത സമയങ്ങളിൽ എന്തെങ്കിലും മാറ്റം വരുത്തണമെങ്കിൽ അതും നിങ്ങള്ക്ക് ചെയ്യാവുന്നതാണ്.
V. നിങ്ങള്ക്ക് സ്വന്തമായി Googlepay/Phonepay ഉണ്ടായിരിക്കണം. അതിലേക്കു മാത്രമായിരിക്കും സാലറി അയക്കുന്നത്. മുകളിൽ പറഞ്ഞിരിക്കുന്ന കാര്യങ്ങൾ ഓരോരുത്തരും നിർബന്ധമായും പാലിക്കേണ്ടതാണ്.
''';
final String id;
  const TermsAndConditionsScreen({super.key,required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  buildCard('English', termsEnglish),
                  const SizedBox(height: 16),
                  buildCard('Malayalam', termsMalayalam),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  child: const Text('Back'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ApiCallFunctions.instance.terms(id);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                      return MainHomeAgent(); 
                    },));
                    // Handle the agree action
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  child: const Text('Agree'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(String title, String content) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            Text(content),
          ],
        ),
      ),
    );
  }
}

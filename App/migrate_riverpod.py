import os
import re

directory = r'c:\Work\Sustho\App\lib\screens'

for root, _, files in os.walk(directory):
    for file in files:
        if file.endswith('.dart'):
            path = os.path.join(root, file)
            with open(path, 'r', encoding='utf-8') as f:
                content = f.read()
                
            if 'package:provider/provider.dart' in content:
                print(f'Migrating {path}')
                
                # Replace import
                content = content.replace("import 'package:provider/provider.dart';", "import 'package:flutter_riverpod/flutter_riverpod.dart';\nimport '../../core/providers/app_providers.dart';")
                
                # Replace StatelessWidget
                content = re.sub(r'class\s+(\w+)\s+extends\s+StatelessWidget', r'class \1 extends ConsumerWidget', content)
                content = re.sub(r'Widget\s+build\(\s*BuildContext\s+context\s*\)', r'Widget build(BuildContext context, WidgetRef ref)', content)
                
                # Replace StatefulWidget
                content = re.sub(r'class\s+(\w+)\s+extends\s+StatefulWidget', r'class \1 extends ConsumerStatefulWidget', content)
                content = re.sub(r'State<(\w+)>\s+createState\(\)\s*=>\s*_\w+State\(\);', r'ConsumerState<\1> createState() => _\1State();', content)
                content = re.sub(r'class\s+_(\w+)State\s+extends\s+State<(\w+)>', r'class _\1State extends ConsumerState<\2>', content)
                
                # Replace context.watch/read
                # Step 1: Replace syntax
                content = re.sub(r'context\.watch<(\w+)>\(\)', r'ref.watch(\1Provider)', content)
                content = re.sub(r'context\.read<(\w+)>\(\)', r'ref.read(\1Provider)', content)
                
                # Step 2: Fix casing of provider names (e.g. CycleControllerProvider -> cycleControllerProvider)
                def lower_first(match):
                    return f"ref.{match.group(1)}({match.group(2).lower()}{match.group(3)}"
                content = re.sub(r'ref\.(watch|read)\(([A-Z])(\w*Provider)\)', lower_first, content)
                
                with open(path, 'w', encoding='utf-8') as f:
                    f.write(content)
print("Migration script finished.")

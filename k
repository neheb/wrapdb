diff --git a/tools/sanity_checks.py b/tools/sanity_checks.py
index 1a5d3f63..271a815d 100755
--- a/tools/sanity_checks.py
+++ b/tools/sanity_checks.py
@@ -348,6 +348,7 @@ class TestReleases(unittest.TestCase):
             deps = [d for d in deps if d not in skip_deps]

         options = ['-Dpython.install_env=auto', f'-Dwraps={name}']
+        options.append('--cross-file=/home/mangix/devstuff/hashcat/mingw64-cross.txt')
         options.append('-Ddepnames={}'.format(','.join(deps or [])))
         options.append('-Dprognames={}'.format(','.join(progs or [])))
         if ci.get('fatal_warnings', True) and self.fatal_warnings:

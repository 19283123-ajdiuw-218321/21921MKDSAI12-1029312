from pathlib import Path
import subprocess
import tempfile
import sys

root=Path(__file__).resolve().parents[1]
tools=Path(sys.argv[1]).resolve() if len(sys.argv)>1 else root.parent/'luau-tools'
source=(root/'Boxer_fighter_Test_V2.lua').read_text(encoding='utf-8')
start=source.index('-- V21D: each queued defense')
end=source.index('function MURIM_GH.loadDanger()',start)
cases=(root/'tests/grey_defense_cases.luau').read_text(encoding='utf-8')
def extract(first,last):
    a=source.index(first)
    return source[a:source.index(last,a+len(first))]
integration=extract('local function canParry()', '-- A06-only parry path.')
integration+=extract('function MURIM_HD.attack(root,mob,now)', '-- V20H: loot na Heart Demon')
integration+=extract('function MURIM_HD.artifactBlocked()', 'function MURIM_HD.artifactUsed(')
cases=cases.replace('-- INTEGRATION_INSERT',integration)
assert cases.count('-- MODULE_INSERT')==1
with tempfile.TemporaryDirectory() as directory:
    path=Path(directory)
    suite=path/'cases.luau'
    suite.write_text(cases.replace('-- MODULE_INSERT',source[start:end]),encoding='utf-8')
    subprocess.run([str(tools/'luau.exe'),str(suite)],check=True)
    inner=path/'inner.luau'
    inner.write_text(source.split('local source = [====[',1)[1].split(']====]',1)[0],encoding='utf-8')
    for file in (root/'Boxer_fighter_Test_V2.lua',inner):
        subprocess.run([str(tools/'luau-compile.exe'),'--null',str(file)],check=True)
# The unrelated movement/combat logic must match the last published version.
previous=subprocess.check_output(['git','show','b0afb2e:Boxer_fighter_Test_V2.lua'],cwd=root).decode('utf-8')
for first,last in [('function MURIM_A03.', 'function MURIM_A04.'),
                   ('function MURIM_A04.', '-- V19'),
                   ('function MURIM_HD.retreatCheck(', 'function MURIM_HD.hpWatch('),
                   ('function MURIM_GH.hideTick(', 'function MURIM_GH.fleeTick(')]:
    def block(text):
        a=text.index(first)
        return text[a:text.index(last,a+len(first))]
    assert block(source)==block(previous),first
print('PASS: loader and inner chunk compile; unrelated selected combat/retreat sections preserved')

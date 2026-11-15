"""Extract observed timing constraints; replay cannot establish server-side parry success."""
from pathlib import Path
import re
import json
import sys

path=Path(sys.argv[1])
lines=path.read_text(encoding='utf-8').splitlines()
events=[]
for line in lines:
    if 'Golpe de ' not in line or '[EVIDENCIA]' not in line:
        continue
    exact=re.search(r'Act=FormationSeal \(acerto previsto ha ([\d.]+)s',line)
    possible=re.search(r'FormationSeal \(acerto -([\d.]+)s\)\s*$',line)
    if exact or possible:
        lag=float((exact or possible).group(1))
        events.append({'time':line[1:9], 'observed_lag':lag,
                       'association':'existing log attribution' if exact else 'last temporal candidate, unconfirmed',
                       'v21c_estimate':0.9,
                       'outside_0_22s_input_hold':not (0.78<=lag<=1.0)})
assert events,'No matching events in supplied log'
print(json.dumps({'source':path.name,'events':events,
 'limit':'Timing reconstruction only: ParryDown/Up hold is not proof of the server parry window or accepted defense.'},indent=2))

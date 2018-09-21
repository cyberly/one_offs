#!/usr/bin/python

##Read data from a CSV, spit out some nginx rewrites. 

import csv
import re

base_csv = "404.csv"
data = csv.reader(open(base_csv, "r"), delimiter=',')
r_outfile = "rewrites.txt"
i_outfile = "invalid.csv"
d_outfile = "duplicates.txt"
rewrites = []
bad_format = []
duplicates = []

#Main page redirects
for line in data:
    #This could be done cleaner but creating functions is for nerds.
    exp = "^mybaseurl"
    raw_uri = re.sub(exp, '', line[0])
    redir_uri = re.sub(exp, '', line[7])
    if not redir_uri:
        redir_uri = "/"
    base_loc = re.sub('\?.*$', '', raw_uri)
    #Don't redirect / back to /
    if base_loc == "/":
        bad_format.append(line)
        continue
    #None of these characters should be in the URI at this point
    bad_chars = ['&', '(', ')', '%', ':']
    if any(x in base_loc for x in bad_chars):
        bad_format.append(line)
        continue
    if base_loc not in rewrites:
        rewrites.append([base_loc, redir_uri])
    else:
        duplicates.append(line[0])

rewrite_file = open(r_outfile, "a")
for line in rewrites:
    if not line[0].startswith("/"):
        line[0] = "/" + line[0]
    entry = "rewrite ^" + line[0] + "$ " + line[1] + " permanent;\n"
    rewrite_file.write(entry)
if duplicates:
    duplicate_csv = csv.writer(open(d_outfile, 'a'), delimiter=',')
    for line in duplicates:
        duplicate_csv.writerow(line)
invalid_csv = csv.writer(open(i_outfile, 'a'), delimiter=',')
for line in bad_format:
    invalid_csv.writerow(line)

print("Valid rewrites: %s" % len(rewrites))
print("Duplicate entries: %s" % len(duplicates))
print("Invalid entries: %s" % len(bad_format))

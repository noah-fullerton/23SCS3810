"""
CS3810: Principles of Database Systems
Instructor: Thyago Mota
Student(s): Noah Fullerton
Description: A data load script for the IPPS database
"""

import psycopg2
import configparser as cp
import csv

config = cp.RawConfigParser()
config.read('ConfigFile.properties')
params = dict(config.items('db'))


prov = '''
PREPARE prov (int, text, text, text, text, int, int, float) AS
INSERT INTO Providers (Rndrng_Prvdr_CCN, Rndrng_Prvdr_Org_Name, Rndrng_Prvdr_St, Rndrng_Prvdr_City, Rndrng_Prvdr_State_Abrvtn, Rndrng_Prvdr_State_FIPS, Rndrng_Prvdr_Zip5, RUCA_cd) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
;
'''

ruca = '''
PREPARE ruca (float, text) AS
INSERT INTO RUCAs (Rndrng_Prvdr_RUCA, Rndrng_Prvdr_RUCA_Desc) VALUES 
($1, $2);
'''
            
drg = '''
PREPARE drg AS
INSERT INTO DRGs VALUES($1);
'''

stats = '''
PREPARE stats AS
INSERT INTO Stats VALUES($1);
'''

conn = psycopg2.connect(**params)
if conn: 
    cur = conn.cursor()
    cur.execute('DEALLOCATE ALL;')
    cur.execute(ruca)
    cur.execute(prov)
    cur.execute(drg)
    cur.execute(stats)
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')
    with open('..\data\MUP_IHP_RY22_P02_V10_DY20_PrvSvc.csv', newline='') as csvfile:
        reader = csv.reader(csvfile)
        isFirstRow = True
        for row in reader:
            if isFirstRow:
                isFirstRow = False
                continue
            try:
                Rndrng_Prvdr_CCN = row[0]
                Rndrng_Prvdr_Org_Name = row[1]
                Rndrng_Prvdr_St = row[2]
                Rndrng_Prvdr_City = row[3]
                Rndrng_Prvdr_State_Abrvtn = row[4]
                Rndrng_Prvdr_State_FIPS = row[5]
                Rndrng_Prvdr_Zip5 = row[6]
                Rndrng_Prvdr_RUCA = float(row[7])
                Rndrng_Prvdr_RUCA_Desc = row[8]
                DRG_Cd = row[9]
                DRG_Desc = row[10]
                Tot_Dschrgs = row[11]
                Avg_Submtd_Cvrd_Chrg = row[12]
                Avg_Tot_Pymt_Amt = row[13]
                Avg_Mdcr_Pymt_Amt = row[14]

                cur.execute('EXECUTE prov ({0}, \'{1}\', \'{2}\', \'{3}\', \'{4}\', {5}, {6}, {7})'.format(Rndrng_Prvdr_CCN, Rndrng_Prvdr_Org_Name, Rndrng_Prvdr_St, Rndrng_Prvdr_City, Rndrng_Prvdr_State_Abrvtn, Rndrng_Prvdr_State_FIPS, Rndrng_Prvdr_Zip5, Rndrng_Prvdr_RUCA))
                cur.execute('EXECUTE ruca ({0}, \'{1}\')'.format(Rndrng_Prvdr_RUCA, Rndrng_Prvdr_RUCA_Desc))
                conn.commit()
                #cur.execute(prov, (Rndrng_Prvdr_CCN, Rndrng_Prvdr_Org_Name, Rndrng_Prvdr_St, Rndrng_Prvdr_City, Rndrng_Prvdr_State_Abrvtn, Rndrng_Prvdr_State_FIPS, Rndrng_Prvdr_Zip5))
            except psycopg2.IntegrityError:
                conn.rollback()
            #except psycopg2.DatabaseError:
                #conn.rollback()

        print('Bye!')
        conn.commit()
        conn.close()
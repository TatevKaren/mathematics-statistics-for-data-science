
df = pd.read_csv("/Users/tatev/Downloads/data.csv", encoding='ISO-8859-1')


def get_KS_stat_onesided(long_or_short, sector, df):
   print("D_stat one sided that pre is smaller than post for sector", sector)
   print("The window type", long_or_short)
   if sector == 0:
      if (long_or_short == "long"):
          KS_stat = stats.kstest(df["diff_BC"], 'norm', alternative= "less")
      else:
          KS_stat = stats.kstest(df["diff_DC"], 'norm', alternative= "less")
   else:
       if (long_or_short == "long"):
           KS_stat = stats.kstest(df[df["Sector_Group"] == sector]["diff_BC"], 'norm')
       else:
           KS_stat = stats.kstest(df[df["Sector_Group"] == sector]["diff_DC"], 'norm')

   print(KS_stat)


get_KS_stat_onesided("long", 0 , df)
print("-----------------------------------------------------------------------")
get_KS_stat_onesided("long", 1 , df)
print("-----------------------------------------------------------------------")



get_KS_stat_onesided("short", 0, df)
print("-----------------------------------------------------------------------")
get_KS_stat_onesided("short", 1, df)
print("-----------------------------------------------------------------------")




# References

## 1 Allocation Flag

See link: [Introduction to data editing and allocation](https://usa.ipums.org/usa/flags.shtml)

### Allocation rule of thumbs

Computer editing of census data falls into three basic categories:

* __Logical Edits__. (data quality codes 1-3) Logical edits infer missing or inconsistent values from other information available in the person record or elsewhere in the household, on the basis of a set of rules. For example, the marital status "never married" is inferred for persons under age twelve with missing information, and a race of "white" is inferred for persons with white parents present in the household. Logical edits are usually quite reliable.

* __Hot Deck Allocation__. (data quality codes 4-6) In cases where logical edits are impossible, hot deck techniques are used. This involves searching the data file for a "donor" record which shares key characteristics with the missing, illegible or inconsistent case. For example, in the 1950 sample if sex was missing or illegible and could not be logically inferred from other characteristics, the sex of the most proximate person record which had the same household type and size, race, age, marital status, and relation to household head was allocated.

* __Cold Deck Allocation__. (data quality codes 7-8) Occasionally, when a hot deck allocation failed to find a suitable donor record, cold deck allocation was used. This method involves randomly assigning a value from a pre-determined distribution, or assigning a modal value.

### What allocation flags look like

* 2000, 2010, ACS, PRCS data
    * 0 - Unaltered case
    * 4 - Allocated (method not specified)

### What our data looks like


* FTOILP 1 (Flush toilet allocation flag)
    * b .N/A (GQ)
    * 0 .No
    * 1 .Yes



## 2 Data source

http://www.census.gov/programs-surveys/acs/data/pums.html

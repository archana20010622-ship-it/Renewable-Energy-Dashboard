






-------------Create Integration Object------------------------


CREATE OR REPLACE STORAGE INTEGRATION Tableau_Integration
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = S3
ENABLED = TRUE
STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::972379852958:role/tableau.role'
STORAGE_ALLOWED_LOCATIONS = ('s3://archana.tableau.project/')
COMMENT = 'Optional Comment'



desc integration Tableau_Integration



-------------------------------------------Loading data--------------------------------------------------

CREATE database tableau;

create schema tableau_Data;

create table tableau_dataset (
Household_ID	string,Region	string,Country	string,Energy_Source	string,
Monthly_Usage_kWh	float,Year	int,Household_Size	int,Income_Level	string,
Urban_Rural	string,Adoption_Year	int,Subsidy_Received	string,Cost_Savings_USD float);


select * from tableau_dataset;



create stage tableau.tableau_Data.tableau_stage
url = 's3://archana.tableau.project'
storage_integration = Tableau_Integration

desc stage tableau_stage




copy into tableau_dataset 
from @tableau_stage
file_format = (type=csv field_delimiter=',' skip_header=1 )
on_error = 'continue'

list @s1



----------------------Renewable Energy Dataset understanding-----------------------

select * from tableau_dataset;




----Making a copy of this table

Create table  energy_consumption
as select * from tableau_dataset


select * from energy_consumption





-------------------------------------------Modifications---------------------------------------------------------

--- 1. Increase Savings for Subsidized Households by 15%

    ------Business Logic: Households receiving government subsidies save more money.-----

            update energy_consumption
            set COST_SAVINGS_USD=COST_SAVINGS_USD*1.15
            where SUBSIDY_RECEIVED='Yes'

            select * from energy_consumption


----2. Create Adoption Status

   --- Business Logic: Identify early and recent adopters.

          ALTER table energy_consumption
          add ADOPTION_STATUS STRING;


          update energy_consumption
          set ADOPTION_STATUS=
          case
              when Year<=2022 then 'Early Adopter'
              else 'Recent Adopter'
          end;



        select ADOPTION_STATUS, count(*) from energy_consumption 
        group by ADOPTION_STATUS


----3. Increase Biomass Energy Usage by 8%

    --  Business Logic: Biomass adoption is growing.

        UPDATE energy_consumption 
        SET MONTHLY_USAGE_KWH = MONTHLY_USAGE_KWH * 1.08
        WHERE ENERGY_SOURCE = 'Biomass';



---4. Create Usage Category

        --Business Logic: Classify households by electricity consumption.

        Alter table  energy_consumption
        add USAGE_CATEGORY STRING;



        update energy_consumption
        set USAGE_CATEGORY=
        case
            when MONTHLY_USAGE_KWH<200 then 'Low Usage'
            when MONTHLY_USAGE_KWH>=200 and MONTHLY_USAGE_KWH<=500 then 'Medium Usage'
            else 'High Usage'
        END;
		 
		 

        select USAGE_CATEGORY, count(*) from energy_consumption 
        group by USAGE_CATEGORY



---5.ALTER TABLE RENEWABLE_ENERGY_USAGE

       ALTER TABLE energy_consumption
       ADD COLUMN GREEN_RATING STRING;


        update energy_consumption
        set GREEN_RATING=
        CASE
             WHEN SUBSIDY_RECEIVED = 'Yes' AND COST_SAVINGS_USD > 500 THEN 'Gold'
             WHEN COST_SAVINGS_USD >400  THEN 'Silver'
             ELSE 'Bronze'
        END


      select GREEN_RATING, count(*) from energy_consumption 
      group by GREEN_RATING

 
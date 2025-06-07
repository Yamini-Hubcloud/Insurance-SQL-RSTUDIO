 install.packages("readxl") 
library(readxl) 
CUSTOMER <- read_excel("C:/Users/Admin/Desktop/MSc BA/7101 DM/Data 
1_Customer.xlsx") 
View(CUSTOMER) 
library(readxl) 
M_P <- read_excel("C:/Users/Admin/Desktop/MSc BA/7101 DM/Data 2_Motor 
Policies.xlsx") 
View(M_P) 
library(readxl) 
H_P<- read_excel("C:/Users/Admin/Desktop/MSc BA/7101 DM/Data 3_Health 
Policies.xlsx") 
View(H_P) 
library(readxl) 
T_P <- read_excel("C:/Users/Admin/Desktop/MSc BA/7101 DM/Data 4_Travel 
Policies.xlsx") 
View(T_P) 
## JOIN TABLES ## 
 install.packages("dplyr") 
library("dplyr") 
 ABTS<- CUSTOMER %>% 
  left_join(M_P, by = "MotorID")%>%          
  left_join(H_P, by = "HealthID") %>%        
  left_join(T_P, by = "TravelID")  
16 
View(ABTS) 
## REMOVE UNWANTED COULMNS ## 
library(dplyr) 
ABTS <- ABTS  %>% 
  select(-HealthDependentsAdults,-DependentsKids, -veh_value, -clm, -Numclaims, -v_body, 
         PolicyEnd.x,  -v_age, -PolicyEnd.y, -policyStart.x, -policyEnd, -policyStart.y) 
## MUTATE  ## 
 ABTS$Occupation<- ifelse(is.na(ABTS$Occupation), 
                           ABTS$Occupation) -Exposure,  -LastClaimDate,-PolicyStart, 
"Not 
Mentioned", 
ABTS$HealthID<- ifelse(is.na(ABTS$HealthID), "No Customer" , ABTS$HealthID) 
ABTS$HealthType <- ifelse(is.na(ABTS$HealthType ), "No policy", ABTS$HealthType ) 
ABTS$MotorID<- ifelse(is.na(ABTS$MotorID), "No Customer" , ABTS$MotorID) 
ABTS$MotorType<- ifelse(is.na(ABTS$MotorType), "No policy", ABTS$MotorType) 
ABTS$TravelID<- ifelse(is.na(ABTS$TravelID), "No Customer" , ABTS$TravelID) 
ABTS$TravelType<- ifelse(is.na(ABTS$TravelType), "No policy", ABTS$TravelType) 
ABTS <- ABTS %>% 
  mutate(CardType = ifelse(CardType == "0", "No Card", CardType)) 
ABTS <- ABTS %>% 
  mutate(Gender = ifelse(Gender == "F", "female", Gender)) 
ABTS <- ABTS %>% 
  mutate(Gender = ifelse(Gender == "f", "female", Gender)) 
ABTS <- ABTS %>% 
  mutate(Gender = ifelse(Gender == "M", "male", Gender)) 
ABTS <- ABTS %>% 
  mutate(Gender = ifelse(Gender == "m", "male", Gender)) 
ABTS <- ABTS %>% 
  mutate(ComChannel = ifelse(ComChannel == "S", "SMS",ComChannel)) 
ABTS <- ABTS %>% 
  mutate(ComChannel = ifelse(ComChannel == "P", "Phone",ComChannel)) 
ABTS <- ABTS %>% 
  mutate(ComChannel = ifelse(ComChannel == "E", "Email",ComChannel)) 
## CREATING NEW COLUMN FOR ANALYSING  EXISTING VARIABLES ## 
17 
 ABTS <- ABTS %>% 
  mutate(Age_category = case_when( 
    is.na(Age) ~ "Invalid", 
    Age < 0 ~ "Negative", 
    Age >= 1 & Age <= 18 ~"0 TO 18", 
    Age >= 19  & Age <= 25 ~"19 T0 25", 
    Age >= 25 & Age <= 40 ~  "25 TO 40", 
    Age >= 40 & Age <=60 ~"40 TO 60", 
    Age >= 60 & Age <=100 ~ "MORE THAN 60", 
    Age  >= 101 ~ "MORE THAN 100" 
  )) 
 ABTS <- ABTS %>% 
  select(CustomerID, Age,Age_category, everything()) 
ABTS$TOTAL_POLICIES  
"TravelID")])) 
<- rowSums(!is.na(ABTS[, c("HealthID", "MotorID", 
                           ##  CREATE SUMMARY FOR DATA ## 
                           ##OUTLIERS FOR NUMERICAL DATA ## 
                            outliers<-boxplot(ABTS$Age)$out 
                           ABTS$Age[ABTS$Age< 0]<-NA 
                           ABTS$Age[ABTS$Age> 100]<-NA 
                           18 
                           ## CODES FOR  GRAPHICAL  REPRESENTATION ## 
                            MOSAIC PLOT – AGE CATEGORY 
                           ABTS$Age_category <- as.factor(ABTS$Age_category) 
                           tablect <- table(ABTS$Age_category) 
                           mosaicplot(tablect, 
                                      main = "Mosaic Plot", 
                                      xlab = "AGE CATEGORY", 
                                      ylab = "RANGE ", 
                                      col = c("turquoise", "salmon", "lightpink","yellow","skyblue","pink","red"),  
                                      border = "black") 
                            PIE CHART – COM CHANNEL 
                           library(dplyr) 
                           library(ggplot2) 
                           SMS <- sum(ABTS$ComChannel == "SMS", na.rm = TRUE) 
                           PHONE <- sum(ABTS$ComChannel == "Phone", na.rm = TRUE) 
                           EMAIL<- sum(ABTS$ComChannel == "Email", na.rm = TRUE) 
                           View(Scount) 
                           View(Pcount) 
                           View(ecount) 
                           counts_comchannel<- c(SMS, PHONE,EMAIL) 
                           values = c("SMS", "PHONE","EMAIL") 
                           pie(counts_comchannel, labels = paste(values, "(", counts_comchannel, ")", sep = ""), 
                               main = "Pie Chart of Comchannel ", col = c("lightblue", "lightgreen", "lightcoral")) 
                            PIE CHART – COUNT OF NO OF POLICIES 
                           policies3 <- sum(ABTS$TOTAL_POLICIES == 3, na.rm = TRUE) 
                           policies2 <- sum(ABTS$TOTAL_POLICIES == 2, na.rm = TRUE) 
                           policies1<- sum(ABTS$TOTAL_POLICIES == 1, na.rm = TRUE) 
                           View(policies3) 
                           View(policies2) 
                           View(policies1) 
                           counts_TOTAL<- c(975,2088,899) 
                           value = c("two policies", "one policies","three policies") 
                           pie(counts_TOTAL, labels = paste(value, "(", counts_TOTAL, ")", sep = ""), 
                               main = "Pie Chart of policies ", col = c("gold", "lightyellow", "yellow")) 
                            PIE CHART -  TYPES OF POLICIES 
                           hptotal <- sum(!is.na(ABTS$HealthID)) 
                           MPtotal <- sum(!is.na(ABTS$MotorID)) 
                           TPtotal <- sum(!is.na(ABTS$TravelID)) 
                           View(hptotal) 
                           View(TPtotal) 
                           19 
                           View(MPtotal) 
                           counts_POLICIES<- c(2538, 3357, 2105) 
                           sector= c("HEALTH POLICIES", "MOTOR POLICIES","TRAVEL POLICIES") 
                           pie(counts_POLICIES, labels = paste(sector, "(", counts_POLICIES, ")", sep = ""), 
                               main = "Pie Chart of POLICIES ", col = c("cyan", "grey", "magenta")) 
                            MOSAIC PLOT - GENDER COUNTS VS COMCHANNEL  
                           ABTS$Gender <- as.factor(ABTS$Gender) 
                           ABTS$ComChannel <- as.factor(ABTS$ComChannel) 
                           cntcy_table <- table(ABTS$Gender, ABTS$ComChannel) 
                           mosaicplot(cntcy_table, 
                                      main = "Mosaic Plot", 
                                      xlab = "Gender", 
                                      ylab = "ComChannel", 
                                      col = c("turquoise", "salmon", "lightpink"),  
                                      border = "black") 
                            STACKED BAR CHART  LOCATION VS  COMCHANNEL 
                           library(ggplot2) 
                           ggplot(ABTS, aes(x = Location, fill = ComChannel)) + 
                             geom_bar(position = "stack",stat = "count") + 
                             geom_text(stat = "count", aes(label = ..count..),  
                                       position = position_stack(vjust = 0.5), size = 3) + 
                             labs(title = "Stacked Bar Plot", x = "ComChannel", y = "count") + 
                             scale_fill_manual(values = c("skyblue", "lightgreen", "salmon")) + 
                             theme_minimal()  
                            STACKED BAR CHART   AGE CATEGORY VS  COMCHANNEL 
                           ggplot(ABTS, aes(x = Age_category, fill = ComChannel)) + 
                             geom_bar(position = "stack",stat = "count") + 
                             geom_text(stat = "count", aes(label = ..count..),  
                                       position = position_stack(vjust = 0.5), size = 3) + 
                             labs(title = "Stacked Bar Plot", x = "ComChannel", y = "count") + 
                             scale_fill_manual(values = c("red", "yellow", "cyan")) + 
                             theme_minimal()  
                            STACKED BAR CHART   CARDTYPE VS COMCHANNEL 
                           ggplot(ABTS, aes(x =Gender, fill = ComChannel)) + 
                             geom_bar(position = "stack",stat = "count") + 
                             geom_text(stat = "count", aes(label = ..count..),  
                                       position = position_stack(vjust = 0.5), size = 3) + 
                             labs(title = "Stacked Bar Plot", x = "ComChannel", y = "count") + 
                             scale_fill_manual(values = c("tomato2" , "snow2" , "salmon2"    )) + 
                             theme_minimal()  
                           20 
                            MOSAIC PLOT – GENDER VS CARD TYPE 
                           ABTS$HP <- ifelse(ABTS$HealthID != "No Customer" & !is.na(ABTS$HealthID), 1, 0) 
                           ABTS$MP <- ifelse(ABTS$MotorID!= "No Customer" & !is.na(ABTS$MotorID), 1, 0) 
                           ABTS$TP <- ifelse(ABTS$TravelID != "No Customer" & !is.na(ABTS$TravelID), 1, 0) 
                           library(dplyr) 
                           Count_gp <- ABTS %>% 
                             group_by(Gender) %>% 
                             summarise( 
                               healthpolicy= sum(HP), 
                               Motorpolicy = sum(MP), 
                               Travelpolicy= sum(TP) 
                             ) 
                           print(Count_gp) 
                           mosaicplot (Count_gp, 
                                       main = "Mosaic Plot", 
                                       xlab = "Gender", 
                                       ylab = "policies", 
                                       labels = rep(ABTS$Gender, each = ncol(Count_gp)), 
                                       col = c( "mediumturquoise","mistyrose2", "moccasin"), 
                                       border = "black") 
                            BAR CHART - HEALTH TYPE  
                           Level1 <- sum(ABTS$HealthType == "Level1", na.rm = TRUE) 
                           Level2<- sum(ABTS$HealthType == "Level2", na.rm = TRUE) 
                           Level3<- sum(ABTS$HealthType == "Level3", na.rm = TRUE) 
                           View(Level1) 
                           View(Level2) 
                           View(Level3) 
                           type<- c("Level1", "Level2","Level3") 
                           lev= c(659, 1253, 629) 
                           ggplot(ABTS, aes(x = HealthType )) + 
                             geom_bar(fill = "skyblue") + 
                             geom_text(stat = "count", aes(label = ..count..),  
                                       position = position_stack(vjust = 0.5), size = 3)+ 
                             labs(title = "Health  type ", x = "Health  policies", y = "Frequency") 
                            MOSAIC CHART – GENDER POLICIES COUNT 
                           ABTS$HP <- ifelse(ABTS$HealthID != "No Customer" & !is.na(ABTS$HealthID), 1, 0) 
                           ABTS$MP <- ifelse(ABTS$MotorID!= "No Customer" & !is.na(ABTS$MotorID), 1, 0) 
                           ABTS$TP <- ifelse(ABTS$TravelID != "No Customer" & !is.na(ABTS$TravelID), 1, 0) 
                           21 
                           library(dplyr) 
                           Count_gp <- ABTS %>% 
                             group_by(Gender) %>% 
                             summarise( 
                               healthpolicy= sum(HP), 
                               Motorpolicy = sum(MP), 
                               Travelpolicy= sum(TP) 
                             ) 
                           print(Count_gp) 
                           mosaicplot (Count_gp, 
                                       main = "Mosaic Plot", 
                                       xlab = "Gender", 
                                       ylab = "policies", 
                                       labels = rep(ABTS$Gender, each = ncol(Count_gp)), 
                                       col = c( "mediumturquoise","mistyrose2", "moccasin"), 
                                       border = "black") 
                            BAR CHART -  MOTOR TYPE  
                           single <- sum(ABTS$MotorType == "Single", na.rm = TRUE) 
                           Bundle<- sum(ABTS$MotorType == "Bundle", na.rm = TRUE) 
                           View(single) 
                           View(Bundle) 
                           typem<- c("single", "Bundle") 
                           sty= c(2285, 1072) 
                           frequency<- table 
                           ggplot(ABTS, aes(x = MotorType )) + 
                             geom_bar(fill = "lightgreen") + 
                             geom_text(stat = "count", aes(label = ..count..),  
                                       position = position_stack(vjust = 0.5), size = 3)+ 
                             labs(title = "Motor type ", x = "Motor policies", y = "Frequency") 
                            BAR CHART -TRAVEL TYPE 
                           Backpacker <- sum(ABTS$TravelType == "Backpacker", na.rm = TRUE) 
                           Senior<- sum(ABTS$TravelType == "Senior", na.rm = TRUE) 
                           Busines<- sum(ABTS$TravelType == "Business", na.rm = TRUE) 
                           Premium <- sum(ABTS$TravelType == "Premium ", na.rm = TRUE) 
                           Standard <- sum(ABTS$TravelType == "Standard ", na.rm = TRUE) 
                           ggplot(ABTS, aes(x = TravelType )) + 
                             geom_bar(fill = "violet") + 
                             geom_text(stat = "count", aes(label = ..count..),  
                                       position = position_stack(vjust = 0.5), size = 3)+ 
                             labs(title = "travel type ", x = " travel policies", y = "Frequency") 
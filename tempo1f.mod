
close all;

var
  k_t         //capital services
  l_t         //labour (hours)
  w_t         //nominal wage
  z_t         //final output
  v_t         //value added
  c_t         //total consumption
  copt_t      //consumption of optimising household
  crot_t      //consumption of rule of thumb household
  i_t         //business investment

  g_t         //goverment spending
  cg_t        //fed gov consumption
  ig_t        //fed gov investment
  tr_t        //fed gov transfer
  txh_t       //fed gov tax revenue from households 
  txf_t       //fed gov tax revenue from firms 
  ntx_t       //fed gov non tax revenue 
  b_t         //fed gov debt 
  pd_t        //primary deficit
  pdv_t       //primary deficit ratio to gdp
  d_t         //overall deficit
  bv_t        //debt-to-gdp ratio (proxy)
  
  x_t         //exports
  mz_t        //imports of non energy
  zf_t        //global trade (not needed, but in the model)
  mon_t       //money demand
  r_t         //norminal interest rate
  rb_t        //borrowing rates 
  rule_t      //mp rule
  rk_t        //rate of return on capital (ie nominal gross interest rate)
  q_t         //real exchange rate (+ve is appreciation, not the textbook definition)
  tq_t        //tobins q (ie shadow value of capital)
  rf_t        //global interest rate
  vf_t        //global value added
  vgap_t      //output gap
  vgapf_t     //global output gap
  vtrend_t    //trend output
  vtrendgap_t //trend output gap
  vdot_t      //out[ut growth
  vdotann_t   //annual output growth 

  gammaz_t    //common trend, stochastic non-stationary growth trend (ie real GDP growth trend)
  gammal_t    //common trend, stochastic non-stationary labour hour trend
  gammavf_t   //common trend, stochastic non-stationary global value added trend

  mcz_t       //marginal cost of final output
  mcv_t       //marginal cost of value added
  mcx_t       //marginal cost of exports
  mcm_t       //marginal cost of import
  mrs_t       //marginal rate of substitution of labour
  mcvf_t      //marginal cost of global value added

  piz_t       //final output added inflation (ie producer price inflation)
  piv_t       //value added inflation
  pic_t       //cpi inflation (ie consumer price inflation)
  corepic_t   //core cpi inflation
  corepicann_t    //annual core inflation
  piexp_t     //export price inflation
  pim_t       //import inflation
  piw_t       //wage inflation
  pie_t       //energy price inflation
  pixf_t      //global export price inflation
  picf_t      //global cpi inflation
  picann_t    //annual cpi inflation
  picfann_t   //global annual cpi inflation
  pieann_t    //annual energy inflation 
  muztempann_t  //annual temporary shock to inflation 

  pv_t        //value added price
  pc_t        //cpi price
  pexp_t      //export price
  pm_t        //import price
  pxf_t       //global export price
  pe_t        //energy price
  pcomf_t     //commodity price
  pipcomf_t   //commodity price inflation
  pcomd_t     //commodity price (domestic currency)
  pipcomd_t

  credith_t   //credit supply, households
  creditf_t   //credit supply, firms
  credit_t    //total credit
  lendg_t     //lending to government (holding of securities)
  oa_t        //other assets, banks  
  loan_t      //external funding
  depp_t      //private deposit funding
  networth_t  //bank net worth (total equity)
  fund_t      //total funding 
  ol_t        //other liabilities, banks
  
  //shock process variables
  epsr_t      //policy rate, monetary policy
  epsb_t      //risk premium
  epsbf_t     //uip
  epsc_t      //consumption preference
  epsi_t      //investment adjustment
  
  epsg_t      //government spending
  epscg_t     //fed gov consumption
  epsig_t     //fed gov investment 
  epstr_t     //fed gov transfer 
  epstxh_t    //fed gov tax revenue from households
  epstxf_t    //fed gov tax revenue from firms
  epsntx_t    //fed gov non tax reenue
  epsd_t      //fed gov soft debt constraint
  
  epsloan_t   //external wholesale funding of banks
  epsdepp_t   //private deposit funding of the bank
  epsbnet_t   //networth of banks
  epsbbank_t  //endogenous premium from leverage (fund-networth)
  epsbglob_t  //exogenous global premium (soverign CDS or EBMI global EM spread)
  epsoa_t     //other assets of banks
  epssch_t    //household credit (boom)
  epsscf_t    //business credit (boom)
  epsscg_t    //credit to government
  
  epskappaf_t //export preference
  epsm_t      //import preference
  epstfp_t    //tfp
  epsl_t      //labour hour
  epslap_t    //labour augmented productivity
  omegaf_t    //relative productivity
  muztemp_t    //temporaty (transitory) shock to final output price
  mum_t       //import price mark up
  muw_t       //wage mark up
  mux_t       //export price mark uo
  muz_t       //final price mark up
  muv_t       //value added price mark up
  
  epszf_t     //global demand, trade
  epscf_t     //foreign consumption preference
  epsrf_t     //foreign interest rate policy
  muvf_t      //foreign value added mark up
  epspcomf_t  //global commodity price

  //flexible price variables (adding "flex")  
  kflex_t lflex_t zflex_t vflex_t cflex_t coptflex_t crotflex_t iflex_t xflex_t mzflex_t zfflex_t monflex_t 
  pcflex_t pvflex_t pmflex_t pxfflex_t pefflex_t peflex_t wflex_t rbflex_t rflex_t rkflex_t qflex_t tqflex_t pexpflex_t rfflex_t vfflex_t
  mrsflex_t gflex_t cgflex_t igflex_t trflex_t txhflex_t txfflex_t ntxflex_t bflex_t 
  credithflex_t creditfflex_t lendgflex_t oaflex_t networthflex_t fundflex_t olflex_t loanflex_t deppflex_t 
  epsbbankflex_t epsbglobflex_t epsbflex_t 
  
  //quarterly change of observable variables
  dlnv_t dlnl_t dlnlabprod_t dlne_t dlnwnom_t dlnk_t dlnc_t dlnx_t dlnpx_t dlng_t dlncg_t dlnig_t  dlnm_t dlni_t dlnw_t
  dlnzf_t dlnvf_t dlngdpstar_t dlnvann_t dlncann_t dlniann_t dlngann_t dlnxann_t dlnmann_t rann_t spread_t
  dlncgann_t dlnigann_t dlntrann_t dlntxhann_t dlntxfann_t dlnntxann_t
  dlncreditann_t dlncredithann_t dlncreditfann_t 
  
  dlnzfann_t dlnvfann_t rfann_t pipcomfann_t dlntr_t dlntxh_t dlntxf_t dlnntx_t
  dlnloan_t dlndepp_t  dlnfund_t dlnnetworth_t dlncredit_t dlncredith_t dlncreditf_t dlnlendg_t dlnoa_t dlnol_t 
  globspread_t banklev_t 
;

varexo
  etar_t          //unsystematic monetary policy shock
  //etab_t        //risk premium (not used)
  etabf_t         //external risk premium shock
  etac_t          //consumption preference
  etai_t          //investment adjustment shock (shock to marginal efficiency of investment)
  
  etag_t          //government spending shock
  etacg_t         //fed gov consumption shock
  etaig_t         //fed gov investment shock
  etatr_t         //fed gov transfer shock
  etatxh_t        //fed gov tax revenue from huseholds shock
  etatxf_t        //fed gov tax revenue from firms shock
  etantx_t        //fed gov non tax revenue shock
  etad_t          //fed gov soft debt constraint
  
  etaloan_t       //foreign borrowing shock
  etadepp_t       //private deposit shock
  etasch_t        //credit to household
  etascf_t        //credit to firm
  etascg_t        //credit to government shock
  etanet_t        //banking networth shock
  etabglob_t      //global premium shock  
  etaoa_t         //other assets shock
  
  etakappaf_t     //global preference for export shock
  etam_t          //import demand shock
  etal_t          //labour hour shock
  etatfp_t        //tfp shock
  etalap_t        //labour-augmenting productivity (note it is a permanent shock affecting the steady states)
  etanonl_t       //labour hour trend
  etaomegaf_t     //relative productivity
  
  etamuz_t        //final price markup shock
  etamuztemp_t    //temporary final output price markup (transitory)
  etamuv_t        //value added markup shock
  etamux_t        //export price markup shock
  etamum_t        //import price markup shock
  etamuw_t        //wage markup shoc

  etarf_t         //global monetary policy
  etazf_t         //global demand shock
  etacf_t         //global consumption preference
  etapxf_t        //global export price shock
  etamuvf_t       //global price markup
  
  etape_t         //domestic energy price 
  etapcomf_t      //global commodity price shock 

  mec_t
  mei_t           //measurement error, business investment
  meg_t
  mex_t
  mem_t
;

parameters
  thetar thetapi thetav sigmar //domestic mp parameters
  phiz phiv phix phim phiw xiz xiv xix xim xiw omegaz omegav omegax omegam omegaw //price setting parameteres
  omegao psic epsilonc psiv psii psim psil epsilonv epsilonl epsilonf  //household related parameters
  
  //rhob 
  rhobf rhoc rhoi rhokappaf rhom rhol rhotfp //persistence of shocks
  rhomuz rhomuv rhomux rhomum rhomuw //persistence of marginal cost shocks
  
  //sigmab 
  sigmabf sigmac sigmai sigmakappaf sigmam //scale parameteres 
  sigmamec sigmamei sigmameg sigmamex sigmamem
  sigmamuz sigmamuztemp sigmamuv sigmamux sigmamum sigmamuw sigmal sigmatfp //scale parameteres 
           
  rhog rhocg rhoig rhotr rhotxh rhotxf rhontx rhod phicgv phicgb phiigv phiigb phitrv phitrb phitxhv phitxhb phitxfv phitxfb phintxv phintxb
  phitxfi phintxi phitxfrk sigmag sigmacg sigmaig sigmatr sigmatxh sigmatxf sigmantx sigmad //fiscal policy
  
  kappac kappaf
  rhosch rhoscf rholend thetag phirlend rhooa rholoan rhodepp rhonw sbank psibank rhobglob
  sigmasch sigmascf sigmascg sigmaoa sigmaloan sigmadepp sigmanet sigmabglob //banking parameters
    
  rholap rhoomegaf sigmalap sigmanonl sigmaomegaf //common trend parameteres
   
  rhope sigmape //domestic energy parameters
  rhopcomf sigmapcomf phimuz phimuv phimux phimum phimuxf phimuvf //commodity prices
  
  thetarf thetapif thetavf sigmarf //foreign mp parameters
  phivf  xivf psicf epsiloncf epsilonlf rhocf rhorf rhomuvf rhozf rhopxf //foreign economy parameters
  sigmazf sigmacf sigmamuvf sigmapxf //foreign standard deviation scales
  
  mh mf //degree of forward lookingness of households and firms 
;

//parameters
//adaptive expectational parameteres
mh        = 1;          //households' degree of forward lookingness  
mf        = 1;          //firms' degree of forward lookingness 

//monetary policy reaction behaviour
thetar    = 0.9445;     //mp, interest rate smoothing
thetapi   = 1.4120;     //mp, inflation response
thetav    = 0.1257;     //mp, output gap response
sigmar    = 0.0385;     //standard error, monetary policy

//households and firms
omegao    = 0.6147;     //share of optimising households (i.e 1-omegao is the conststarined or rule of thumb households)
psic      = 0.1284;     //external habit formation parameter
epsilonc  = 1.1636;     //coeeficient of relative risk aversion, crra (ie inverse of the intertemporal elasticity of substitution)
psiv      = 0.6490;     //value added adjustment cost
psii      = 1.1858;     //investment adjustment cost
psim      = 0.7791;     //non energy import adjustment cost
psil      = 9.4405;     //labour adjustment cost
epsilonv  = 0.8054;     //value added elasticity
epsilonl  = 0.5248;     //elasticity of labour supply
epsilonf  = 0.5071;     //price elasticity of global demand for exports

//price setting behaviour 
phiz      = 0.8977;     //calvo, final output price (probability of keeping price unchanged)
phiv      = 0.8462;     //calvo, value added price
phix      = 0.7158;     //calvo, eport price
phim      = 0.8063;     //calvo, import price
phiw      = 0.8141;     //calvo, wages
xiz       = 0.2173;     //indexation, final output price (degree of backward lookingness)
xiv       = 0.5011;     //indexation, value added price
xix       = 0.4687;     //indexation, export price
xim       = 0.3429;     //indexation, import price
xiw       = 0.2707;     //indexation, wages
omegaz    = 0.2849;     //share of rule of thumb, final output price setters
omegav    = 0.2869;     //share of rule of thumb, value added price setters
omegax    = 0.2211;     //share of rule of thumb, export price setters
omegam    = 0.3177;     //share of rule of thumb, import price setters
omegaw    = 0.2753;     //share of rule of thumb, wage setters

//persistence of domestic shocks
rhobf     = 0.8970;     //persistence parameter, exchange rate risk premium
rhoc      = 0.9497;     //persistence parameter, consumption shock
rhoi      = 0.9508;     //persistence parameter, investment adjustment
rhom      = 0.9551;     //persistence parameter, import preference
rhomuz    = 0;          //persistence parameter, final output price
rhomuv    = 0;          //persistence parameter, value added price
rhomum    = 0;          //persistence parameter, import price markup
rhomux    = 0;          //persistence parameter, export price markup
rhomuw    = 0;          //persistence parameter, wage markup
rhotfp    = 0.9267;     //persistence parameter, tfp
rhol      = 0.9756;     //persistence parameter, labour supply

//scales for standard errors of domestic shocks
sigmabf   = 0.2579;     //standard error, exchange rate risk premium
sigmac    = 0.3905;     //standard error, consumption preference
sigmai    = 0.3918;     //standard error, investment adjustment
sigmam    = 1.1054;     //standard error, import preference
sigmamuz  = 0.1225;     //standard error, final output price markup
sigmamuztemp = 0.2835;  //standard error, temporary final output price markup
sigmamuv = 2.0420;      //standard error, value added price markup
sigmamux  = 1.9340;     //standard error, export price markup
sigmamum  = 0.9110;     //standard error, import price markup
sigmamuw  = 1.6274;     //standard error, wage markup
sigmal    = 7.9609;     //standard error, labour hour supply
sigmatfp  = 1.5965;     //standard error, tfp

//common trends (calibrated)
rholap    = 0.925;      //persistence parameter, lap
rhoomegaf = 0.5;        //persistence parameter, relative domestic-global productivity
sigmalap  = 0.1;        //standard error, lap
sigmanonl = 0.1;        //standard error, labour hour trend
sigmaomegaf = 0.1;      //standard error, relative productivity

//fiscal block
phitxfi   = 0.0517;     //"crowding out" effect firm tax on investment
phintxi   = 0.0340;     //"crowding out" effect non tax on investment
phitxfrk  = 0.0987;     //"crowding out" effect firm tax on cost of capital

rhog      = 0.8203;     //persistence parameter, government consumption
rhocg     = 0.7986;     //persistence parameter, fed gov consumption
rhoig     = 0.8846;     //persistence parameter, fed gov investment
rhotr     = 0.9157;     //persistence parameter, fed gov transfer
rhotxh    = 0.6378;     //persistence parameter, fed gov tax on households
rhotxf    = 0.9066;     //persistence parameter, fed gov tax on firms
rhontx    = 0.9256;     //persistence parameter, fed gov non tax revenue
rhod      = 0.5355;     //persistence parameter, fed gov soft debt
phicgv    = 0.2867;     //(negative) sensitivity of gov consumption to output
phicgb    = 0.3324;     //(negative) sensitivity of gov consumption to debt
phiigv    = 0.2369;     //(negative) sensitivity of gov investment to output
phiigb    = 0.1126;     //(negative) sensitivity of gov investment to debt
phitrv    = 0.1577;     //(negative) sensitivity of gov transfer to output
phitrb    = 0.1575;     //(negative) sensitivity of gov transfer to debt
phitxhv   = 0.1980;     //(positive) sensitivity of gov household tax to output
phitxhb   = 0.2709;     //(positive) sensitivity of gov household tax to debt
phitxfv   = 0.2236;     //(positive) sensitivity of gov firm tax to output
phitxfb   = 0.1420;     //(positive) sensitivity of gov firm tax to debt
phintxv   = 0.1986;     //(positive) sensitivity of gov non tax to output
phintxb   = 0.1013;     //(positive) sensitivity of gov non tax to debt

sigmag    = 4.6822;     //standard error, government spending
sigmacg   = 3.4300;     //standard error, fed gov consumption
sigmaig   = 7.5848;     //standard error, fed gov investment
sigmatr   = 9.1014;     //standard error, fed gov transfer
sigmatxh  = 16.4761;    //standard error, fed gov household tax
sigmatxf  = 7.1614;     //standard error, fed gov firm tax
sigmantx  = 8.6783;     //standard error, fed gov non tax
sigmad    = 1.1714;     //standard error, "soft budget constraint"

//banking block
kappac    = 0.0123;     //strength of credit quantity friction, households
kappaf    = 0.1782;     //strength of credit quantity friction, businesses

rhosch    = 0.9472;     //persistence of household credit boom 
rhoscf    = 0.9523;     //persistence of firm credit boom
rholend   = 0.8670;     //persistence of credit to government
thetag    = 0.0976;     //sensitivity to government financing needs (absorbtion by bank of new government financing need)
phirlend  = 0.1023;     //“risk premium sensitivity or strength of “flight to safety or portfolio rebalancing toward government paper
rhooa     = 0.8033;     //persistence of other assets of banks
rholoan   = 0.7993;     //persistence of external borrowings
rhodepp   = 0.8824;     //persistence of private deposits
rhonw     = 0.9567;     //persistence of net worth 
sbank     = 0.1742;     //retained profit fraction
psibank   = 0.0126;     //leverage (premium sensitivity)
rhobglob  = 0.7379;     //persistence of exogenous global premium 

sigmasch   = 2.2089;    //standard error, credit to households
sigmascf   = 1.6497;    //standard error, credit to firms
sigmascg   = 10.6364;   //standard error, credit to government
sigmaoa    = 2.8995;    //standard error, other assets
sigmaloan  = 10.8320;   //standard error, external borrowings
sigmadepp  = 2.1078;    //standard error, private deposit funding
sigmanet   = 2.5090;    //standard error, bank's networth
sigmabglob = 0.0547;    //standard error, global risk premium 

//foreign economy block
thetarf   = 0.7162;     //foreign mp, interest rate smoothing
thetapif  = 1.4602;     //foreign mp, inflation response
thetavf   = 0.2610;     //foreign mp, output gap response
phivf     = 0.9234;     //calvo, global value added price
xivf      = 0.2530;     //indexation, global value added price
psicf     = 0.1326;     //global habit formation parameter
epsiloncf = 0.8812;     //global crra
epsilonlf = 0.6159;     //global labour elasticity
rhocf     = 0.8745;     //persistence parameter, global consumption
rhorf     = 0.8559;     //persistence parameter, global monetary policy
rhomuvf   = 0;          //persistence parameter, global price markup
rhopxf    = 0.9528;     //persistence parameter, global export price (tempo2)
rhozf     = 0.9430;     //persistence parameter, global trade
rhokappaf = 0.9561;     //persistence parameter, export preference

sigmarf   = 0.1049;     //standard error, global monetary policy
sigmacf   = 1.8693;     //standard error, global consumption preference
sigmamuvf = 0.1460;     //standard error, global value added price markup
sigmapxf  = 1.3333;     //standard error, global export price markup 
sigmazf   = 1.6001;     //standard error, global trade
sigmakappaf = 2.6821;   //standard error, (global) export preference

//domestic energy price (fuel, electricity and cooking gas)
rhope     = 0.99;       //persistence parameter, global energy price
sigmape   = 5.5051;     //standard error, global energy price

//commodity price  
rhopcomf  = 0.95;       //persistence of global commodity price
sigmapcomf = 8.5255;    //standard error, global commodity price
phimuz = 0.0081;
phimuv = 0.0143;             //sensitivity of final output marginal cost to commodity price 
phimux = 0.0280;
phimum = 0.0282;
phimuxf = 0.0142; 
phimuvf = 0.0079;            //sensitivity of global value added price to commodity price

//measurement errors
sigmamec  = 0.9234;    //measurement error, household consumption
sigmamei  = 3.9559;    //measurement error, business investment
sigmameg  = 0.2310;    //measurement error, government spending
sigmamex  = 1.6603;    //measurement error, exports
sigmamem  = 2.9345;    //measurement error, imports


model; //(linear);
//controling blocks
# FP = 1; //control for fiscal block
# BS = 1; //control for banking block

//steady states
//core macro foundation
# pistar   = 1 + 2.0/400;      // inflation target  (may be 1+2/400)
# piz      = pistar;           // final output inflation
# beta     = 0.9975;           // discount factor, adjusted to match average real policy rate 
# r        = piz / beta;       // nominal interest rate
# deltak   = 12/400;           // depreciation rate of capital
# rk       = 1 / beta - (1 - deltak);  // return on capital
# spread   = 3/400;            // spread between lending rate and policy rate
# rb       = piz / beta - 1 + spread;  // borrowing rate 

//output composition, share in GDP
# omegacv  = 0.60;             // household consumption 
# omegagv  = 0.13;             // government spending 
# omegaigv = 0.04;             // federal government investment
# omegaxv  = 0.70;             // exports 
# omegamv  = 0.65;             // imports 
# omegaiv = 1 - omegacv - omegagv - FP*omegaigv - omegaxv + omegamv; // business investment (residual)
# omegazv  = omegacv + omegaiv + omegaigv + omegagv + omegaxv;    // final output to value added ratio
# omegavz  = 1 / omegazv;      // value added to final output ratio

//production, factor income and markups
# omegakv  = omegaiv / (1 - (1 - deltak)); // capital stock share
# omegalv  = 2/3;              // labor share in value added
# l        = 1;                // labor hours, normalized to one
# omegawv  = omegalv;          // wage share in value added
# alphal   = 1 / (1 + rk * omegakv / omegawv);  // labor elasticity
# muv      = alphal / omegalv; // value-added markup (≈ 1.1–1.3 typical)
# mcv      = 1 / muv;          // marginal cost of value added
# muz      = 1.005;            // final output markup (≈ 1.01–1.05 typical)
# alphav   = omegavz * muz;    // share of value added in final output

//additional parameters
# pc          = 1;             // consumer price normalization
# alphacz     = 0.9;           // non-energy share in consumption
# alphalf     = 0.65;          // global labor share
# phizf       = 1;             // scale parameter to global demand 

//fiscal block (calibrated), share in GDP 
# omegacgv   = 0.10;           //fed gov consumption
# omegatrv   = 0.045;          // government transfers
# omegabv    = 2.6600;         // government debt-to-GDP ratio
# omegarev   = omegacgv + omegaigv + omegatrv + (r - 1)*omegabv; // required steady-state revenue
# omegatxv   = (3/4) * omegarev;     // tax revenue  
# omegatxh   = (1/3) * omegatxv;     //household tax
# omegatxf   = (2/3) * omegatxv;     //firm tax
# omegantxv  = (1/4) * omegarev;     // non-tax revenue  

//banking block, share in GDP
//assets
# omegacrv   = 4.45;            // total credit 
# omegacrhv  = 0.1798*omegacrv;  // household credit 
# omegacrfv  = omegacrv - omegacrhv; // firm credit
# omegalendgv = 0.6;            // bank lending to government (loan + securities)
# omegaoav   = 2.5;             // other bank assets 
# omegaav    = omegacrv + omegalendgv + omegaoav; //total asset 
//liabilities
# omeganwv   = 0.8;            // bank net worth  
# omegaloanv = 0.30;           // external borrowings
# omegadeppv = 5.4;           // private sector deposit 
# omegafdv   = omegaloanv + omegadeppv; // total funds  
# omegaolv   = omegaav - omeganwv - omegaloanv - omegadeppv; //other liabilities

//steady state levels
# z     = omegazv * omegakv^((1 - alphal)/alphal) * l;  // final output
# v     = z / omegazv;          // value added
# c     = omegacv  * v;         // consumption
# i     = omegaiv  * v;         // investment
# g     = omegagv  * v;         // government spending
# x     = omegaxv  * v;         // exports
# m     = omegamv  * v;         // imports
# k     = omegakv  * v;         // capital stock
# w     = omegawv  * v;         // wages

# cg    = omegacgv * v;         // fed gov consumption
# ig    = omegaigv * v;         // fed gov investment
# tr    = omegatrv  * v;        // transfers
# b     = omegabv   * v;        // public debt
# ds    = (r-1) * b;            //debt service
# tx    = omegatxv  * v;        // tax revenue
# txh   = omegatxh * v;         // tax revenue from households
# txf   = omegatxf * v;         // tax revenue from firms
# ntx   = omegantxv * v;        // non-tax revenue
# fp    = cg + ig + tr + ds;    // ayammas

# cr    = omegacrv  * v;        // total credit
# crh   = omegacrhv * v;        // credit to households
# crf   = omegacrfv * v;        // credit to firms
# lendg = omegalendgv * v;        // credit to government
# oa    = omegaoav  * v;        // other assets
# nw    = omeganwv  * v;        // bank net worth
# loan  = omegaloanv * v;       // external funds (borrowings)
# depp  = omegadeppv * v;       // private sector deposit
# fd    = omegafdv  * v;        // total funds
# ol    = omegaolv  * v;        // other liabilities

//derived ratios
# WLPCC  = (w*l) / (pc*c);      // wage share in household consumption
# TXHC   = txh / c;              // tax-to-consumption ratio
# NTXC   = ntx / c;             // non-tax-toconsumption ratio
# TRC    = tr / c;              // transfer-to-consumption ratio
# VNB    = v / nw;              // output-to-net worth
# GV     = g / v;               // government spending-to-value added
# TXV    = tx / v;              // tax-to-value added ratio 
# NTXV   = ntx / v;             // non-tax-to-value added ratio 
# BV     = b / v;               // debt-to-gdp ratio
# TRV    = tr / v;              // tax-to-value added 
# R      = 1 / beta;            // real interest rate  
# WNB    = (w*l) / nw;          // wage-to-net worth
# RLBNB  = (rb*fd) / nw;        // liability cost-to-net worth

# alphadep   = depp / (depp + loan); // private sector deposits share in total funding
# alphacredh = crh / (crh + crf);    // household credit share in total credit
# alphacredf = crf / (crh + crf);    // firm credit share in total credit

# philoanh   = crh / (depp + loan);  // household credit ratio to total funding
# philoanf   = crf / (depp + loan);  // firm credit ratio to total funding
# sh         = (omegao * c) / crh;  // scaling for household credit
# sf         = i / crf;             // scaling for firm credit

# alphach      = crh / (crh + crf + lendg + oa);
# alphacf      = crf / (crh + crf + lendg + oa);
# alphaoa      = oa  / (crh + crf + lendg + oa);
# alphag       = lendg / (crh + crf + lendg + oa);
# alphafd      = fd  / (crh + crf + lendg + oa);
# alphanw      = nw  / (crh + crf + lendg + oa);
# alphaol      = ol  / (crh + crf + lendg + oa);

//average growth rates of observables (annualized)
# avev      = 4 * 1.125;  // real GDP growth
# avec      = 4 * 1.50;   // consumption growth
# avei      = 4 * 1;      // investment growth
# aveg      = 4 * 1.5;    // government spending growth
# avex      = 4 * 1;      // export growth
# avem      = 4 * 1;      // import growth
# aver      = 4 * 0.75;   // policy rate (OPR)
# avepic    = 4 * 0.50;   // headline inflation
# avecpic   = 4 * 0.50;   // core inflation
# avezf     = 4 * 0.875;  // global trade growth
# avevf     = 4 * 0.8125; // global GDP growth
# avepicf   = 4 * 0.50;   // global inflation
# averf     = 4 * 0.75;   // FFR (US rate)
# avepicomf = 4 * 1.0;    // global commodity inflation
# avepie    = 4 * 0.50;   // domestic energy inflation
# avecg     = 4 * 1;      // federal government consumption growth
# aveig     = 4 * 0.675;  // federal government investment growth
# avetr     = 4 * 1.975;  // federal government transfer growth
# avetxh    = 4 * 1.25;   // household tax growth
# avetxf    = 4 * 1.050;  // firm tax growth
# aventx    = 4 * 1.25;   // non tax tax growth
# avecrh    = 4 * 1.375;  // household credit
# avecrf    = 4 * 1.1875; // firm credit
# avecrt    = 4 * 1.25;   // credit


//price rigidity block
//household sector
copt_t = 1/(1+psic)*mh*copt_t(+1) + psic/(1+psic)*copt_t(-1)
  - (1-psic)/(epsilonc*(1+psic)) *(r_t-mh*pic_t(+1) + epsb_t - mh*gammaz_t(+1)
  - epsc_t + mh*epsc_t(+1)) + BS*( - kappac*(copt_t - sh*credith_t)); //consumption euler 
epsc_t = rhoc*epsc_t(-1) + sigmac*etac_t; //consumption preference shock process
rb_t = r_t + epsb_t;  //borrowing rate 
crot_t = (w*l/pc*c)*(w_t + l_t - pc_t) + FP*( - (txh/c)*txh_t + (tr/c)*tr_t); //consumption of rule of thumb households 
mon_t = 1/(1-psic)*(copt_t-psic*copt_t(-1)) - 1/(epsilonc*r)*r_t + (1/epsilonc)*pc_t; //money demand 
q_t = mh*q_t(+1) + (r_t - rf_t - mh*piz_t(+1) + mh*picf_t(+1)) - epsbf_t; //uip  
epsbf_t = rhobf*epsbf_t(-1) + sigmabf*etabf_t; //uip risk premia shock process
c_t = omegao*copt_t + (1-omegao)*crot_t; //aggregate (total) consumption  
v_t = (c/v)*c_t + (i/v)*i_t + (g/v)*g_t + (x/v)*x_t + 0*FP*(ig/v)*ig_t - (m/v)*mz_t; //resource constraint (alternative reource constraint)
pic_t = piz_t + pc_t - pc_t(-1); //cpi inflation  

//investment and capital
i_t = 1/(1+beta)*(i_t(-1) - gammaz_t) + beta/(1+beta)*mh*(i_t(+1) + gammaz_t(+1))
      + 1/(1+beta)*(1/psii*tq_t + epsi_t) + FP*( - phitxfi*txf_t - phintxi*ntx_t) + BS*( - kappaf*( i_t - sf*creditf_t));  //investment euler 
tq_t = (1-deltak)/(rk + (1-deltak))*mh*tq_t(+1) - (r_t - mh*piz_t(+1) + epsb_t) + rk/(rk+(1-deltak))*mh*rk_t(+1) + FP*( rk/(rk+(1-deltak))*mh*phitxfrk*txf_t(+1)); //tobins q  
k_t = (1-deltak)*(k_t(-1)-gammaz_t)+(i/k)*(i_t+epsi_t); //capital accumulation  
epsi_t = rhoi*epsi_t(-1) + sigmai*etai_t; //investment adjustment shock process

//labour market 
mrs_t = epsl_t + epsilonl*l_t
      + epsilonc/(1-psic)*(omegao*(copt_t - psic*copt_t(-1)) + (1-omegao)*(crot_t - psic*crot_t(-1))) + pc_t; //marginal rate of substitution of labour 
epsl_t = rhol*epsl_t(-1) + sigmal*etal_t; //labour supply shock process
w_t = piw_t - piz_t - (gammaz_t - gammal_t) + w_t(-1); //wage (relative to price of final output) 
piw_t = muw_t + (1-phiw)*(1-omegaw - (1-omegaw)*beta*phiw)/(phiw*(1+beta*xiw)+(1-phiw)*omegaw)*(mrs_t - w_t)
      + xiw*(phiw+(1-phiw)*omegaw)/(phiw*(1+beta*xiw)+(1-phiw)*omegaw)*piw_t(-1)
      + beta*phiw/(phiw*(1+beta*xiw)+(1-phiw)*omegaw)*mh*piw_t(+1); //labour supply (wage phillips curve) 
muw_t = rhomuw*muw_t(-1) + sigmamuw*etamuw_t; //wage mark up shock process

//final output firms 
z_t = alphav*v_t + (1-alphav)*mz_t; //final output 
mz_t = psim/(1/epsilonv + psim*(1+beta))*(mz_t(-1) - gammaz_t)
     + psim*beta/(1/epsilonv + psim*(1+beta))*mf*(mz_t(+1) + gammaz_t(+1))
     + 1/(1/epsilonv + psim*(1+beta))*(mcz_t - pm_t + (1/epsilonv)*z_t)
     - epsm_t; //imports  
epsm_t = rhom*epsm_t(-1) + sigmam*etam_t; //import preference shock process
v_t = psiv/(1/epsilonv + psiv*(1+beta))*(v_t(-1) - gammaz_t)
    + psiv*beta/(1/epsilonv + psiv*(1+beta))*mf*(v_t(+1) + gammaz_t(+1))
    + 1/(1/epsilonv + psiv*(1+beta))*(mcz_t - pv_t + (1/epsilonv)*z_t); //value added output  
piz_t = (1-phiz)*(1-omegaz-phiz*beta*(1-omegaz))/(phiz*(1+xiz*beta)+(1-phiz)*omegaz)*mcz_t
      + xiz*(phiz+(1-phiz)*omegaz)/(phiz*(1+xiz*beta)+(1-phiz)*omegaz)*piz_t(-1)
      + beta*phiz/(phiz*(1+xiz*beta)+(1-phiz)*omegaz)*mf*piz_t(+1)
      + muz_t + muztemp_t; //final output inflation   
muz_t = rhomuz*muz_t(-1) + sigmamuz*etamuz_t + phimuz*pipcomd_t; //final output price mark up shock process
muztemp_t = sigmamuztemp*etamuztemp_t; //temporary final output price markup  
   
//value added firms
v_t = (1-alphal)*(k_t(-1) - gammaz_t) + alphal*l_t + epstfp_t; //value added production function  
epstfp_t = rhotfp*epstfp_t(-1) + sigmatfp*etatfp_t; //tfp shock process
l_t = psil/(1+psil*(1+beta))*(l_t(-1) - gammal_t)
    + psil*beta/(1+psil*(1+beta))*mf*(l_t(+1) + gammal_t(+1))
    + 1/(1+psil*(1+beta))*(v_t + pv_t + mcv_t - w_t); //demand for labour  
k_t(-1) = v_t + pv_t + mcv_t - rk_t + gammaz_t; //capital services  
pv_t = piv_t - piz_t + pv_t(-1); //relative value added price  
piv_t = (1-phiv)*(1-omegav-phiv*beta*(1-omegav))/(phiv*(1+xiv*beta)+(1-phiv)*omegav)*mcv_t
      + xiv*(phiv+(1-phiv)*omegav)/(phiv*(1+xiv*beta)+(1-phiv)*omegav)*piv_t(-1)
      + beta*phiv/(phiv*(1+xiv*beta)+(1-phiv)*omegav)*mf*piv_t(+1)
      + muv_t; //value added inflation  
muv_t = rhomuv*muv_t(-1) + sigmamuv*etamuv_t + phimuv*pipcomd_t; //value added price mark up shock process (adding cost push from commodity price)

//import firms
mcm_t = pxf_t - q_t - pm_t; //marginal cost of imports  
pxf_t = pixf_t + pxf_t(-1) - picf_t; //global export price relative to global final output price
pxf_t = rhopxf*pxf_t(-1) + sigmapxf*etapxf_t + phimuxf*pcomf_t; //global export price 
pm_t = pim_t - piz_t + pm_t(-1); //relative import price  
pim_t = (1-phim)*(1-omegam-phim*beta*(1-omegam))/(phim*(1+xim*beta)+(1-phim)*omegam)*mcm_t
      + xim*(phim+(1-phim)*omegam)/(phim*(1+xim*beta)+(1-phim)*omegam)*pim_t(-1)
      + beta*phim/(phim*(1+xim*beta)+(1-phim)*omegam)*mf*pim_t(+1)
      + mum_t; //import inflation  
mum_t = rhomum*mum_t(-1) + sigmamum*etamum_t + phimum*pipcomd_t; //import price mark up shock process

//energy price (energy prices are controlled and not systematically related to global price)
pe_t = rhope*pe_t(-1) + sigmape*etape_t; //energy price
pie_t = piz_t + pe_t - pe_t(-1); //energy inflation
pc_t = (1-alphacz)*pe_t; // consumption price excluding energy price 

//export firms
pexp_t = piexp_t - picf_t + pexp_t(-1); //export rice  
piexp_t = (1-phix)*(1-omegax-phix*beta*(1-omegax))/(phix*(1+xix*beta)+(1-phix)*omegax)*mcx_t
        + xix*(phix+(1-phix)*omegax)/(phix*(1+xix*beta)+(1-phix)*omegax)*piexp_t(-1)
        + beta*phix/(phix*(1+xix*beta)+(1-phix)*omegax)*mf*piexp_t(+1)
        + mux_t; //export inflation  
mcx_t = q_t - pexp_t; //marginal cost of export  
mux_t = rhomux*mux_t(-1) + sigmamux*etamux_t + phimux*pipcomd_t; //export price mark up shock process

//fiscal block
g_t = FP*cg_t + epsg_t; //(consolidated) government spending
epsg_t = rhog*epsg_t(-1) + sigmag  * etag_t;  // government spending shock process
cg_t = cg_t(-1) - gammaz_t + (rhocg - 1)*cg_t(-1) + epscg_t + ( - phicgv*v_t - phicgb*b_t); // fed gov spending
epscg_t = sigmacg  * etacg_t;  // government spending shock process
ig_t = ig_t(-1) - gammaz_t + (rhoig-1)*ig_t(-1) + epsig_t + ( - phiigv*v_t - phiigb*b_t); // fed gov investment (residuals)
epsig_t = sigmaig*etaig_t;  // fed gov investment shock process
tr_t = tr_t(-1) - gammaz_t + (rhotr-1)*tr_t(-1) + epstr_t - phitrv*v_t - phitrb*b_t; // fed gov transfer 
epstr_t = sigmatr*etatr_t; // fed gov trasfer shock process 
txh_t = txh_t(-1) - gammaz_t + (rhotxh-1)*txh_t(-1) + epstxh_t + phitxhv*v_t + phitxhb*b_t; // fed gov tax revenue from households
epstxh_t = sigmatxh*etatxh_t; // fed gov tax revenue from household shock process 
txf_t = txf_t(-1) - gammaz_t + (rhotxf-1)*txf_t(-1) + epstxf_t + phitxfv*v_t + phitxfb*b_t; // fed gov tax revenue from firms
epstxf_t = sigmatxf*etatxf_t; // fed gov tax revenue from firm shock process 
ntx_t = ntx_t(-1) - gammaz_t + (rhontx-1)*ntx_t(-1) + epsntx_t + phintxv*v_t + phintxb*b_t; // fed gov non tax revenue 
epsntx_t = sigmantx*etantx_t; // fed gov non tax revenue 

//government budget constraint (gbc)
(cg/v)*cg_t + (ig/v)*ig_t + (tr/v)*tr_t + (b/v)*(1/beta-1)*(r_t(-1) - pic_t) = (txh/v)*txh_t + (txf/v)*txf_t + (ntx/v)*ntx_t + (1/v)*(b_t - (1/beta)*b_t(-1))  + epsd_t; // fed gov budget constraint (real term)
epsd_t = rhod*epsd_t(-1) + sigmad*etad_t; // soft debt constraint

//primary deficit, overall deficit ratios  
pd_t = (cg/fp)*cg_t + (ig/fp)*ig_t + (tr/fp)*tr_t - (txh/fp)*txh_t - (txf/fp)*txf_t - (ntx/fp)*ntx_t; //primary deficit (no interest term)
pdv_t = pd_t - v_t; //
d_t = pd_t + (b/v)*(1/beta - 1)*(r_t(-1) - pic_t) + epsd_t; //overall deficit ratio
bv_t = (b_t - v_t) + (v/b)* epsd_t; //debt to gdp ratio (corrected)

//banking block  
//balancesheet identity
alphach*credith_t + alphacf*creditf_t + alphag*lendg_t + alphaoa*oa_t  //assets
    = alphanw*networth_t + alphafd*fund_t + alphaol*ol_t ; //liabilities
    
//assets
credith_t = philoanh*fund_t + epssch_t; //credit to households 
epssch_t = rhosch*epssch_t(-1) + sigmasch*etasch_t; //household credit shock process
creditf_t = philoanf*fund_t + epsscf_t; //credit to firms  
epsscf_t = rhoscf*epsscf_t(-1) + sigmascf*etascf_t; //firm credit shock process
credit_t = alphacredh*credith_t + (1-alphacredh)*creditf_t;
lendg_t  = rholend*lendg_t(-1) + (1 - rholend)*thetag*(b_t - b_t(-1)) - phirlend*(r_t - rb_t)  - gammaz_t + epsscg_t; // lending to government
epsscg_t  = sigmascg*etascg_t; // lending to government shock process
oa_t = rhooa*oa_t(-1) - gammaz_t + epsoa_t; //other assets
epsoa_t = sigmaoa*etaoa_t;  //other assets shock process

//liabilities
loan_t = loan_t(-1) - gammaz_t + (rholoan - 1)*loan_t(-1) + epsloan_t;  //external wholesale funding (volatile)
epsloan_t = sigmaloan*etaloan_t;  //external borrowings shock process
depp_t  = rhodepp*depp_t(-1) - gammaz_t + epsdepp_t; // private deposits (households + firms)
epsdepp_t   = sigmadepp*etadepp_t; // private deposit shock process
fund_t = alphadep*depp_t + (1 - alphadep)*loan_t; //total funding (private deposit + external borrowings)
networth_t = rhonw*networth_t(-1) + sbank*((VNB*v_t(+1)) - (WNB*w_t(+1)) - (RLBNB*(rb_t(+1) + fund_t))) - gammaz_t(+1) + epsbnet_t; //net worth dynamics (bgg/gk style)
epsbnet_t = sigmanet*etanet_t;  //networth shock process

//risk premium (affecting households and firms)
epsbbank_t = psibank*(fund_t - networth_t); //endogenous premium (leverage)
epsbglob_t = rhobglob*epsbglob_t + sigmabglob*etabglob_t; //exogenous global premium 
epsb_t     = epsbbank_t + epsbglob_t;  //risk premium entering Euler/Tobin-q equations

//monetary policy
r_t = rule_t + epsr_t; //nominal market interest rate  
epsr_t = sigmar*etar_t; //policy rate shock
rule_t = (1-thetar)*(thetapi*(1/4)*
          + (corepic_t + corepic_t(-1) + corepic_t(-2) + corepic_t(-3))     //headline inflation
          + thetav*vgap_t)                                                  //output gap
          + thetar*r_t(-1);                                                 //lag interest rate (smoothing, inertia)

//corepic_t = (1/alphacz)*(pic_t - (1-alphacz)*pie_t - muztemp_t); //core inflation 
//pic_t = alphacz*corepic_t + (1-alphacz)*pie_t + muztemp_t;
corepic_t = (pic_t - (1-alphacz)*pie_t - muztemp_t); //core inflation 

vgap_t = v_t - vflex_t; //output gap  
vtrend_t = (1-alphal)*(k_t(-1) - gammaz_t) + epstfp_t; //production function trend
vtrendgap_t = v_t-vtrend_t; //production function output gap
vdot_t = v_t - v_t(-1); //output growth
vdotann_t = vdot_t + vdot_t(-1) + vdot_t(-2) + vdot_t(-3); //annual output growth

//global economy
vf_t = 1/(1+psicf)*mh*vf_t(+1) + psicf/(1+psicf)*vf_t(-1)
     - (1-psicf)/(epsiloncf*(1+psicf))*(rf_t - mh*picf_t(+1) - mh*gammavf_t(+1)) + (1-rhocf)*epscf_t; //global consumption  
epscf_t = rhocf*epscf_t(-1) + sigmacf*etacf_t;  //global consumption preference shock process     
mcvf_t = ((epsilonlf+1-alphalf)/alphalf + epsiloncf/(1-psicf))*vf_t
     - (epsiloncf*psicf/(1-psicf))*vf_t(-1); //global demad marginal cost  
picf_t = (1-phivf)*(1-phivf*beta)/(phivf*(1+xivf*beta))*mcvf_t + xivf/(1+xivf*beta)*picf_t(-1)
       + beta/(1+xivf*beta)*mh*picf_t(+1) + muvf_t; //global inflation  
muvf_t = rhomuvf*muvf_t(-1) + sigmamuvf*etamuvf_t + phimuvf*pipcomf_t;  //global price mark up shock process (adding cost push from commodity price)       
zf_t = vf_t + phizf*epszf_t; //global demand  
x_t = vf_t + phizf*epszf_t + epskappaf_t - epsilonf*(pexp_t - pxf_t) + omegaf_t; //export  
epskappaf_t = rhokappaf*epskappaf_t(-1) + sigmakappaf*etakappaf_t;  //export preference shock process
epszf_t = rhozf*epszf_t(-1) + sigmazf*etazf_t;  //foreign demand shock process
rf_t =  thetarf*rf_t(-1) + (1-thetarf)*(thetapif*(1/4)*(picf_t + picf_t(-1) + picf_t(-2) + picf_t(-3)) + thetavf*vgapf_t) + epsrf_t; //global monetray policy 
epsrf_t = rhorf*epsrf_t(-1) + sigmarf*etarf_t;  //foreign monetary policy shock process
vgapf_t = (vf_t - vfflex_t); //foreign output gap

//common trends, ie growth rates
gammaz_t = epslap_t + gammal_t - (omegaf_t - omegaf_t(-1)); //productivity growth trend
gammavf_t = epslap_t + gammal_t; //foreign productivity growth trend
epslap_t = rholap*epslap_t(-1) + sigmalap*etalap_t; //labour augmented productivity growth shock process
gammal_t = sigmanonl*etanonl_t; //labour trend
omegaf_t = rhoomegaf*omegaf_t(-1) + sigmaomegaf*etaomegaf_t;  //relative productivity

//commodity price
pcomf_t = rhopcomf*pcomf_t(-1) + epspcomf_t; //commodity price, foreign currency
epspcomf_t = sigmapcomf*etapcomf_t; //global commodity price
pipcomf_t = pcomf_t - pcomf_t(-1); //global commodity price inflation
pcomd_t = pcomf_t - q_t; //commodity price, domestic currency
pipcomd_t = pcomd_t - pcomd_t(-1); //domestic commodity price inflation

//price flexible block 
coptflex_t = 1/(1+psic)*mh*coptflex_t(+1) + psic/(1+psic)*coptflex_t(-1)
  - (1-psic)/(epsilonc*(1+psic)) *(rflex_t + epsbflex_t - mh*gammaz_t(+1)
  - epsc_t + mh*epsc_t(+1)) + BS*( - kappac*(coptflex_t - sh*credithflex_t)); 
//epsb0flex_t = rhob*epsb0flex_t(-1) + etab_t;
rbflex_t= rflex_t + epsbflex_t;  
crotflex_t = (w*l/pc*c)*(wflex_t + lflex_t - pcflex_t) + FP*( - (txh/c)*txhflex_t + (tr/c)*trflex_t); 
monflex_t = 1/(1-psic)*(coptflex_t-psic*coptflex_t(-1)) - 1/(epsilonc*r)*rflex_t + (1/epsilonc)*pcflex_t; 
qflex_t = mh*qflex_t(+1) + (rflex_t - rfflex_t) - epsbf_t; 
cflex_t = omegao*coptflex_t + (1-omegao)*crotflex_t; 
vflex_t = (c/v)*cflex_t + (i/v)*iflex_t + (g/v)*gflex_t + (x/v)*xflex_t + 0*FP*(ig/v)*igflex_t - (m/v)*mzflex_t; 
iflex_t = 1/(1+beta)*(iflex_t(-1) - gammaz_t) + beta/(1+beta)*mh*(iflex_t(+1) + gammaz_t(+1))
      + 1/(1+beta)*(1/psii*tqflex_t + epsi_t) + FP*( - phitxfi*txfflex_t - phintxi*ntxflex_t) + BS*( - kappaf*(iflex_t - sf*creditfflex_t)); 
tqflex_t = (1-deltak)/(rk + (1-deltak))*mh*tqflex_t(+1) - (rflex_t + epsbflex_t) + rk/(rk+(1-deltak))*mh*rkflex_t(+1) + FP*( rk/(rk+(1-deltak))*mh*phitxfrk*txfflex_t(+1)); 
kflex_t = (1-deltak)*(kflex_t(-1)-gammaz_t)+(i/k)*(iflex_t+epsi_t); 
mrsflex_t = epsl_t + epsilonl*lflex_t
      + epsilonc/(1-psic)*(omegao*(coptflex_t - psic*coptflex_t(-1)) + (1-omegao)*(crotflex_t - psic*crotflex_t(-1))) + pcflex_t;  
mrsflex_t = wflex_t;
zflex_t = alphav*vflex_t + (1-alphav)*mzflex_t; 
mzflex_t = psim/(1/epsilonv + psim*(1+beta))*(mzflex_t(-1) - gammaz_t)
     + psim*beta/(1/epsilonv + psim*(1+beta))*mf*(mzflex_t(+1) + gammaz_t(+1))
     + 1/(1/epsilonv + psim*(1+beta))*( - pmflex_t + (1/epsilonv)*zflex_t)
     - epsm_t;  
vflex_t = psiv/(1/epsilonv + psiv*(1+beta))*(vflex_t(-1) - gammaz_t)
    + psiv*beta/(1/epsilonv + psiv*(1+beta))*mf*(vflex_t(+1) + gammaz_t(+1))
    + 1/(1/epsilonv + psiv*(1+beta))*( - pvflex_t + (1/epsilonv)*zflex_t); 
vflex_t = (1-alphal)*(kflex_t(-1) - gammaz_t) + alphal*lflex_t + epstfp_t; 
lflex_t = psil/(1+psil*(1+beta))*(lflex_t(-1) - gammal_t)
    + psil*beta/(1+psil*(1+beta))*mf*(lflex_t(+1) + gammal_t(+1))
    + 1/(1+psil*(1+beta))*(vflex_t + pvflex_t - wflex_t); 
kflex_t(-1) = vflex_t + pvflex_t - rkflex_t + gammaz_t; 
0 = pxfflex_t - qflex_t - pmflex_t; 
pxfflex_t = rhopxf*pxfflex_t(-1) + sigmapxf*etapxf_t; 
pefflex_t = peflex_t; 
peflex_t = rhope*peflex_t(-1) + sigmape*etape_t;
0 = qflex_t - pexpflex_t;    
pcflex_t = (1-alphacz)*peflex_t;  
alphach*credithflex_t + alphacf*creditfflex_t + alphag*lendgflex_t + alphaoa*oaflex_t  //assets
    = alphanw*networthflex_t + alphafd*fundflex_t + alphaol*olflex_t ;  
credithflex_t = philoanh*fundflex_t + epssch_t; 
creditfflex_t = philoanf*fundflex_t + epsscf_t;  
lendgflex_t  = rholend*lendgflex_t(-1) + (1 - rholend)*thetag*(bflex_t - bflex_t(-1)) - phirlend*(rflex_t - rbflex_t)  - gammaz_t + epsscg_t; 
oaflex_t = rhooa*oaflex_t(-1) - gammaz_t + epsoa_t;  
loanflex_t = loanflex_t(-1) - gammaz_t + (rholoan - 1)*loanflex_t(-1) + epsloan_t;   
deppflex_t  = rhodepp*deppflex_t(-1) - gammaz_t + epsdepp_t;  
fundflex_t = alphadep*deppflex_t + (1 - alphadep)*loanflex_t; 
networthflex_t = rhonw*networthflex_t(-1) + sbank*((VNB*vflex_t(+1)) - (WNB*wflex_t(+1)) - (RLBNB*(rbflex_t(+1) + fundflex_t))) - gammaz_t(+1) + epsbnet_t; 
epsbbankflex_t = psibank*(fundflex_t - networthflex_t); 
epsbglobflex_t = rhobglob*epsbglobflex_t + sigmabglob*etabglob_t; 
epsbflex_t = epsbbankflex_t + epsbglobflex_t;
gflex_t = FP*cgflex_t + epsg_t; 
cgflex_t = cgflex_t(-1) - gammaz_t + (rhocg - 1)*cgflex_t(-1) + epscg_t + ( - phicgv*vflex_t - phicgb*bflex_t);
igflex_t = igflex_t(-1) - gammaz_t + (rhoig-1)*igflex_t(-1) + epsig_t + ( - phiigv*vflex_t - phiigb*bflex_t); 
trflex_t = trflex_t(-1) - gammaz_t + (rhotr-1)*trflex_t(-1) + epstr_t - phitrv*vflex_t - phitrb*bflex_t; 
txhflex_t = txhflex_t(-1) - gammaz_t + (rhotxh-1)*txhflex_t(-1) + epstxh_t + phitxhv*vflex_t + phitxhb*bflex_t; 
txfflex_t = txfflex_t(-1) - gammaz_t + (rhotxf-1)*txfflex_t(-1) + epstxf_t + phitxfv*vflex_t + phitxfb*bflex_t;  
ntxflex_t = ntxflex_t(-1) - gammaz_t + (rhontx-1)*ntxflex_t(-1) + epsntx_t + phintxv*vflex_t + phintxb*bflex_t; 
(cg/v)*cgflex_t + (ig/v)*igflex_t + (tr/v)*trflex_t + (b/v)*(1/beta-1)*rflex_t(-1) = (txh/v)*txhflex_t + (txf/v)*txfflex_t + (ntx/v)*ntxflex_t + (1/v)*(bflex_t - (1/beta)*bflex_t(-1)) + epsd_t;
vfflex_t = 1/(1+psicf)*mh*vfflex_t(+1) + psicf/(1+psicf)*vfflex_t(-1)
     - (1-psicf)/(epsiloncf*(1+psicf))*(rfflex_t - mh*gammavf_t(+1)) + (1-rhocf)*epscf_t; 
0 = ((epsilonlf+1-alphalf)/alphalf + epsiloncf/(1-psicf))*vfflex_t
     - (epsiloncf*psicf/(1-psicf))*vfflex_t(-1); 
zfflex_t = vfflex_t + phizf*epszf_t; 
xflex_t = vfflex_t + phizf*epszf_t + epskappaf_t - epsilonf*(pexpflex_t - pxfflex_t) + omegaf_t;

//quarterly change of observable variables
dlnv_t = v_t - v_t(-1) + gammaz_t;  //demeaned real GDP growth
dlnl_t = l_t - l_t(-1) + gammal_t;  //demeaned hours of worked growth
dlnlabprod_t = dlnv_t - dlnl_t; //demeaned labour productivity growth
dlne_t = q_t - q_t(-1) - piz_t + picf_t;  //demeaned norminal exchange rate change
dlnwnom_t = piw_t;  //demeaned nominal wage growth
dlnk_t = k_t - k_t(-1) + gammaz_t;  //demeaned real capital stock growth
dlnc_t = c_t - c_t(-1) + gammaz_t + sigmamec*mec_t;  //demeaned real consumption growth
dlnx_t = x_t - x_t(-1) + gammaz_t + sigmamex*mex_t;  //demeaned real export growth
dlnpx_t = pexp_t - pexp_t(-1) - q_t + q_t(-1) + piz_t;  //demeaned export price inflation
dlng_t = g_t - g_t(-1) + gammaz_t + sigmameg*meg_t;  //demeaned real government consumption
dlncg_t = cg_t - cg_t(-1) + gammaz_t; //demeaned real federal goverment consumption
dlnig_t = ig_t - ig_t(-1) + gammaz_t; //demeaned real government investment
dlntr_t = tr_t - tr_t(-1) + gammaz_t; //demeaned fed gov transfer
dlntxh_t = txh_t - txh_t(-1) + gammaz_t; //demeaned fed gov tax revenue from households
dlntxf_t = txf_t - txf_t(-1) + gammaz_t; //demeaned fed gov tax revenue from firms
dlnntx_t = ntx_t - ntx_t(-1) + gammaz_t; //demeaned fed gov non tax revenue
dlnm_t = mz_t - mz_t(-1) + gammaz_t + sigmamem*mem_t;  //demeaned real import growth
dlni_t = i_t - i_t(-1) + gammaz_t + sigmamei*mei_t;  //demeaned real investment growth 
dlnw_t = w_t - w_t(-1) + (gammaz_t - gammal_t); //demeaned wage growth
dlnzf_t = zf_t - zf_t(-1) + gammavf_t;  //demeaned global trade growth
dlnvf_t = vf_t - vf_t(-1) + gammavf_t;  //demeaned global GDP growth
dlngdpstar_t = vflex_t - vflex_t(-1) + gammaz_t;  //dmeaned real potential GDP growth
spread_t = rb_t - r_t;  //demeaned total risk premium (lending-policy spread)

dlnloan_t = loan_t - loan_t(-1) + gammaz_t; //demeaned external borrowings growth 
dlndepp_t = depp_t - depp_t(-1) + gammaz_t;  //demeaned private sector deposits growth
//dlndepg_t = depg_t - depg_t(-1) + gammaz_t;  //demeaned government deposits growth
//dlndep_t = dep_t - dep_t(-1) + gammaz_t;  //demeaned domestic deposits growth
dlnfund_t = fund_t - fund_t(-1) + gammaz_t; //demeaned total bank funding growth
dlncredith_t = credith_t - credith_t(-1) + gammaz_t;  //demeaned household credit growth
dlncreditf_t = creditf_t - creditf_t(-1) + gammaz_t;  //demeaned firm credit growth
dlncredit_t  = credit_t  - credit_t(-1)  + gammaz_t;  //demeaned total credit growth (weighted)
dlnlendg_t   = lendg_t - lendg_t(-1)  + gammaz_t;     //demeaned lending to government
dlnnetworth_t = networth_t - networth_t(-1) + gammaz_t; //demeaned bank networth
dlnoa_t = oa_t - oa_t(-1) + gammaz_t; //demeaned other asset holdings growth (e.g. gov. securities)
//dlncash_t = cash_t - cash_t(-1) + gammaz_t; //demeaned real cash
dlnol_t = ol_t - ol_t(-1) + gammaz_t; //demeaned residual other liabilities growth
globspread_t  = epsbglob_t;  //demeaned global risk premium (CDS/EMBI spread)
banklev_t = fund_t - networth_t;  //demeaned leverage ratio proxy (funding/equity gap)

//annual change of observable variables
dlnvann_t = dlnv_t + dlnv_t(-1) + dlnv_t(-2) + dlnv_t(-3) + avev; //annual real GDP growth
dlncann_t = dlnc_t + dlnc_t(-1) + dlnc_t(-2) + dlnc_t(-3) + avec; //annual household consumption
dlniann_t = dlni_t + dlni_t(-1) + dlni_t(-2) + dlni_t(-3) + avei; // - eno_t; //annual business investment
dlngann_t = dlng_t + dlng_t(-1) + dlng_t(-2) + dlng_t(-3) + aveg; //annual government consumption
dlnxann_t = dlnx_t + dlnx_t(-1) + dlnx_t(-2) + dlnx_t(-3) + avex; //annual exports
dlnmann_t = dlnm_t + dlnm_t(-1) + dlnm_t(-2) + dlnm_t(-3) + avem; //annual imports
rann_t = 4*r_t + aver;  //annualised opr
picann_t = pic_t + pic_t(-1) + pic_t(-2) + pic_t(-3) + avepic;  // annual inflation  
corepicann_t = corepic_t + corepic_t(-1) + corepic_t(-2) + corepic_t(-3) + avecpic; //annual core inflation
dlnzfann_t = dlnzf_t + dlnzf_t(-1) + dlnzf_t(-2) + dlnzf_t(-3) + avezf; //annual real global trade growth
dlnvfann_t = dlnvf_t + dlnvf_t(-1) + dlnvf_t(-2) + dlnvf_t(-3) + avevf; //annual foreign real GDP growth
picfann_t = picf_t + picf_t(-1) + picf_t(-2) + picf_t(-3) + avepicf; //annaul foreign inflation
rfann_t = 4*rf_t + averf; //annualised foreign policy rate
pipcomfann_t = pipcomf_t + pipcomf_t(-1) + pipcomf_t(-2) + pipcomf_t(-3) + avepicomf; //annual global commodity price
pieann_t = pie_t + pie_t(-1) + pie_t(-2) + pie_t(-3) + avepie; //annual energy inflation  //annual domestic energy inflation
muztempann_t = muztemp_t + muztemp_t(-1) + muztemp_t(-2) + muztemp_t(-3); //temporary shock to inflation

dlncgann_t = dlncg_t + dlncg_t(-1) + dlncg_t(-2) + dlncg_t(-3) + avecg; //annual federal government consumption 
dlnigann_t = dlnig_t + dlnig_t(-1) + dlnig_t(-2) + dlnig_t(-3) + aveig; //annual government investment
dlntrann_t = dlntr_t + dlntr_t(-1) + dlntr_t(-2) + dlntr_t(-3) + avetr; //annual government transfer
dlntxhann_t = dlntxh_t + dlntxh_t(-1) + dlntxh_t(-2) + dlntxh_t(-3) + avetxh; //annual tax on households
dlntxfann_t = dlntxf_t + dlntxf_t(-1) + dlntxf_t(-2) + dlntxf_t(-3) + avetxf; //annual tax on households
dlnntxann_t = dlnntx_t + dlnntx_t(-1) + dlnntx_t(-2) + dlnntx_t(-3) + aventx; //annual tax on households

dlncredithann_t = dlncredith_t + dlncredith_t(-1) + dlncredith_t(-2) + dlncredith_t(-3) + avecrh; //annual growth household credit
dlncreditfann_t = dlncreditf_t + dlncreditf_t(-1) + dlncreditf_t(-2) + dlncreditf_t(-3) + avecrf; //annual credit growth to firms
dlncreditann_t = dlncredit_t + dlncredit_t(-1) + dlncredit_t(-2) + dlncredit_t(-3) + avecrt; //annual credit growth

end;

resid;
steady;
check;

shocks;
var etar_t;       stderr 1;    //monetary policy rate
var etabf_t;      stderr 1;    //exchange rate risk premium
var etac_t;       stderr 1;    //consumption shock
var etai_t;       stderr 1;    //investment adjustment

var etag_t;       stderr 1;    //government spending
var etacg_t;      stderr 1;    //fed gov consumption
var etaig_t;      stderr 1;    //fed gov investment
var etatr_t;      stderr 1;    //fed gov transfer
var etatxh_t;     stderr 1;    //fed gov tax revenue from households
var etatxf_t;     stderr 1;    //fed gov tax revenue from frims
var etantx_t;     stderr 1;    //fed gov non tax revenue
var etad_t;       stderr 1;    //fed gov soft debt constraint

var etaloan_t;    stderr 1;    //capital flow shock
var etadepp_t;    stderr 1;    //private deposit shock
var etasch_t;     stderr 1;    //credit to households shock
var etascf_t;     stderr 1;    //credit to firms shock
var etascg_t;     stderr 1;    //credit to government shock
var etanet_t;     stderr 1;    //banking networth shock
var etabglob_t;   stderr 1;    //global premium shock
var etaoa_t;      stderr 1;    //other assets

var etakappaf_t;  stderr 1;    //export preference
var etam_t;       stderr 1;    //import preference
var etal_t;       stderr 1;    //labour supply
var etatfp_t;     stderr 1;    //tfp
var etalap_t;     stderr 1;    //labour augmented productivity
var etanonl_t;    stderr 1;    //labour hour trend
var etaomegaf_t;  stderr 1;    //relative productivity trend

var etamuz_t;     stderr 1;    //final output price markup
var etamuztemp_t; stderr 1;    //temporary final output price
var etamuv_t;     stderr 1;    //value added price markup
var etamux_t;     stderr 1;    //export price markup
var etamum_t;     stderr 1;    //import price markup
var etamuw_t;     stderr 1;    //wage markup

var etarf_t;      stderr 1;    //global monetary policy
var etazf_t;      stderr 1;    //global demand
var etacf_t;      stderr 1;    //global cnsumption preference
var etapxf_t;     stderr 1;    //global export price
var etamuvf_t;    stderr 1;    //global value added prioce markup 

var etape_t;      stderr 1;    //domestic energy price
var etapcomf_t;   stderr 1;    //global commodity price

var mec_t;        stderr 1;    //measurement error,
var mei_t;        stderr 1;    //measurement error, business investment
var meg_t;        stderr 1;    //measurement error,
var mex_t;        stderr 1;    //measurement error,
var mem_t;        stderr 1;    //measurement error,

end;

/*
stoch_simul (periods=0, irf=12, irf_shocks = ( etape_t )) 
    v_t c_t i_t x_t mz_t g_t l_t w_t  vgap_t vtrend_t vtrendgap_t pic_t pie_t corepic_t r_t q_t tq_t; 
*/
 
//estimation
estimated_params;
/*
//forward-lookingness (degree of myopic)
mh,            0.9963, , ,   beta_pdf,    0.90, 0.05;  //households' degree of forward-lookingness on expectation
mf,            0.9963, , ,   beta_pdf,    0.90, 0.05;  //firms' degree of forward-lookingness on expectation
*/

//estimation without mh and mf (ie mh=mf=1)
//domestic monetary policy
/*
thetar,         0.8259, , ,   beta_pdf,       0.75, 0.1;      //mp interest rate smoothing
thetapi,        1.3944, , ,   normal_pdf,     1.5, 0.1;       //mp inflation response
thetav,         0.1044, , ,   gamma_pdf,      0.25, 0.1;      //mp output gap response
*/
sigmar,         0.0390, , ,   inv_gamma_pdf,  0.1, 0.05;       //standard error, monetary policy

/*
//household and firms
omegao,         0.6529, , ,   beta_pdf,       0.60, 0.05;     //share of optimising households (i.e 1-omegao is the conststarined or rule of thumb households) (fixed)
psic,           0.1349, , ,   beta_pdf,       0.25, 0.1;      //external habit formation parameter
epsilonc,       0.8287, , ,   gamma_pdf,      1, 0.5;         //coeeficient of relative risk aversion, crra (ie inverse of the intertemporal elasticity of substitution)
psiv,           0.5359, , ,   gamma_pdf,      1, 0.5;         //value added adjustment cost
psii,           2.6519, , ,   gamma_pdf,      2, 0.5;         //investment adjustment cost
psim,           0.3944, , ,   gamma_pdf,      1, 0.5;         //import adjustment cost
psil,          16.2714, , ,   gamma_pdf,      10, 2.5;        //labour adjustment cost
epsilonv,       1.0687, , ,   gamma_pdf,      1.0, 0.5;       //value added elasticity
epsilonl,       1.3636, , ,   gamma_pdf,      1, 0.5;         //elasticity of labour supply
epsilonf,       0.5866, , ,   gamma_pdf,      1.0, 0.5;       //price elasticity of global demand for exports

//price setting behaviours
phiz,           0.8954, , ,   beta_pdf,       0.75, 0.1;      //calvo, final output price (probability of keeping price unchanged)
phiv,           0.7851, , ,   beta_pdf,       0.75, 0.1;      //calvo, value added price
phix,           0.7599, , ,   beta_pdf,       0.75, 0.1;      //calvo, eport price
phim,           0.7766, , ,   beta_pdf,       0.75, 0.1;      //calvo, import price
phiw,           0.9029, , ,   beta_pdf,       0.75, 0.1;      //calvo, wages
xiz,            0.2671, , ,   beta_pdf,       0.50, 0.1;      //indexation, final output price (degree of backward lookingness)
xiv,            0.4749, , ,   beta_pdf,       0.50, 0.1;      //indexation, value added price
xix,            0.3837, , ,   beta_pdf,       0.50, 0.1;      //indexation, export price
xim,            0.4073, , ,   beta_pdf,       0.50, 0.1;      //indexation, import price
xiw,            0.1986, , ,   beta_pdf,       0.50, 0.1;      //indexation, wages
omegaz,         0.3835, , ,   beta_pdf,       0.25, 0.1;      //share of rule of thumb, final output price setters
omegav,         0.3913, , ,   beta_pdf,       0.25, 0.1;      //share of rule of thumb, value added price setters
omegax,         0.2156, , ,   beta_pdf,       0.25, 0.1;      //share of rule of thumb, export price setters
omegam,         0.2507, , ,   beta_pdf,       0.25, 0.1;      //share of rule of thumb, import price setters
omegaw,         0.2489, , ,   beta_pdf,       0.25, 0.1;      //share of rule of thumb, wage setters
*/

//persistence of domestic shocks
/*
rhobf,          0.9102, , ,   beta_pdf,       0.95, 0.02;     //persistence parameter, exchange rate risk premium
rhoc,           0.9283, , ,   beta_pdf,       0.95, 0.02;      //persistence parameter, consumption shock
rhoi,           0.8443, , ,   beta_pdf,       0.95, 0.02;      //persistence parameter, investment adjustment
rhom,           0.9052, , ,   beta_pdf,       0.95, 0.02;     //persistence parameter, import preference
rhotfp,         0.9241, , ,   beta_pdf,       0.95, 0.02;     //persistence parameter, tfp
rhol,           0.9672, , ,     beta_pdf,       0.95, 0.02;     //persistence parameter, labour supply
*/

//scales for standard error of domestic shocks
sigmabf,        0.2491, , ,   inv_gamma_pdf,  0.5, 0.25;      //standard error, exchange rate risk premium
sigmac,         0.4871, , ,   inv_gamma_pdf,   0.5, 0.2;      //standard error, consumption preference
sigmai,         0.5165, , ,   inv_gamma_pdf,   0.5, 0.2;      //standard error, investment adjustment
sigmam,         1.0581, , ,   inv_gamma_pdf,  0.5, 0.2;      //standard error, import preference
sigmamuz,       0.1222, , ,   inv_gamma_pdf,  0.2, 0.10;      //standard error, final output price markup
sigmamuztemp,   0.2861, , ,   inv_gamma_pdf,  0.2, 0.10;      //standard error, temporary final output price markup
sigmamuv,       1.6659, , ,   inv_gamma_pdf,  0.5, 0.25;      //standard error, value added price markup
sigmamux,       2.0202, , ,   inv_gamma_pdf,  0.5, 0.25;      //standard error, export price markup
sigmamum,       0.9753, , ,   inv_gamma_pdf,  0.5,0.25;      //standard error, import price markup
sigmamuw,       1.6521, , ,   inv_gamma_pdf,  0.5, 0.25;      //standard error, wage markup
sigmal,         7.6982, , ,     inv_gamma_pdf,  0.5, 0.2;      //standard error, labour hour supply
sigmatfp,       1.6112, , ,     inv_gamma_pdf,  0.5, 0.2;      //standard error, tfp

//fiscal parameters 
//parameteres affecting real sector
/*
phitxfi,        0.0447, , ,   gamma_pdf,      0.1, 0.05;      //"crowding out" effect firm tax on investment
phintxi,        0.0568, , ,   gamma_pdf,      0.1, 0.05;      //"crowding out" effect non tax on investment
phitxfrk,       0.1044, , ,   gamma_pdf,      0.1, 0.05;      //"crowding out" effect firm tax on cost of capital

rhog,           0.8220, , ,   beta_pdf,       0.80, 0.05;     //persistence parameter, government consumption
rhocg,          0.9078, , ,   beta_pdf,       0.80, 0.05;     //persistence parameter, fed gov consumption
rhoig,          0.8907, , ,   beta_pdf,       0.80, 0.05;     //persistence parameter, fed gov investment
rhotr,          0.9352, , ,   beta_pdf,       0.50, 0.2;      //persistence parameter, fed gov transfer
rhotxh,         0.6798, , ,   beta_pdf,       0.50, 0.2;      //persistence parameter, fed gov tax on households 
rhotxf,         0.8487, , ,   beta_pdf,       0.50, 0.2;      //persistence parameter, fed gov tax on firms
rhontx,         0.9103, , ,   beta_pdf,       0.50, 0.2;      //persistence parameter, fed gov non tax revenue
rhod,           0.7236, , ,   beta_pdf,       0.50, 0.2;      //persistence parameter, fed gov soft debt

phicgv,         0.1479, , ,   gamma_pdf,      0.20, 0.1;      //(negative) sensitivity of gov consumption to output
phicgb,         0.1187, , ,   gamma_pdf,      0.20, 0.1;      //(negative) sensitivity of gov consumption to debt
phiigv,         0.2191, , ,   gamma_pdf,      0.20, 0.1;      //(negative) sensitivity of gov investment to output
phiigb,         0.4606, , ,   gamma_pdf,      0.20, 0.1;      //(negative) sensitivity of gov investment to debt
phitrv,         0.1498, , ,   gamma_pdf,      0.20, 0.1;      //(negative) sensitivity of gov transfer to output
phitrb,         0.1186, , ,   gamma_pdf,      0.20, 0.1;      //(negative) sensitivity of gov transfer to debt
phitxhv,        0.2526, , ,   gamma_pdf,      0.20, 0.1;      //(positive) sensitivity of gov household tax to output
phitxhb,        0.1843, , ,   gamma_pdf,      0.20, 0.1;      //(positive) sensitivity of gov household tax to debt
phitxfv,        0.2623, , ,   gamma_pdf,      0.20, 0.1;      //(positive) sensitivity of gov firm tax to output
phitxfb,        0.1129, , ,   gamma_pdf,      0.20, 0.1;      //(positive) sensitivity of gov firm tax to debt
phintxv,        0.2316, , ,   gamma_pdf,      0.20, 0.1;      //(positive) sensitivity of gov non tax to output
phintxb,        0.0746, , ,   gamma_pdf,      0.20, 0.1;      //(positive) sensitivity of gov non tax to debt
*/

sigmag,         4.7171, , ,   inv_gamma_pdf,  4.3, 2.15;      //standard error, government spending
sigmacg,        3.5490, , ,   inv_gamma_pdf,  4.3, 2.15;      //standard error, fed gov consumption
sigmaig,        7.7213, , ,   inv_gamma_pdf,  9.0, 4.5;       //standard error, fed gov investment
sigmatr,        9.2678, , ,   inv_gamma_pdf,  9.0, 4.5;       //standard error, fed gov transfer
sigmatxh,      16.9837, , ,   inv_gamma_pdf, 15.0, 7.5;       //standard error, fed gov household tax
sigmatxf,       7.2191, , ,   inv_gamma_pdf,  6.0, 3.0;       //standard error, fed gov firm tax
sigmantx,       8.8154, , ,   inv_gamma_pdf,  8.0, 4.0;       //standard error, fed gov non tax
sigmad,         1.2687, , ,   inv_gamma_pdf,  1.5, 0.75;      //standard error, "soft budget constraint"

//banking parameters
//credit friction parameters
/*
kappac,         0.2, , ,   gamma_pdf,      0.1, 0.05;    //sensitivity of household to credit supply
kappaf,         0.2, , ,   gamma_pdf,      0.1, 0.05;    //sensitivity of business to credit supply

rhosch,         0.9306, , ,   beta_pdf,       0.8, 0.05;      //persistence of household credit
rhoscf,         0.9537, , ,   beta_pdf,       0.8, 0.05;      //persistence of firm credit
rholend,        0.8966, , ,   beta_pdf,       0.8, 0.05;      //persistence of lending to government  
thetag,         0.0966, , ,   gamma_pdf,      0.1, 0.05;      //sensitivity to government financing needs 
phirlend,       0.0961, , ,   gamma_pdf,      0.1, 0.05;      //“risk premium sensitivity or strength of “flight to safety 
rhooa,          0.7993, , ,   beta_pdf,       0.8, 0.05;      //persistence of other assets of banks

rholoan,        0.8281, , ,   beta_pdf,       0.8, 0.05;      //persistence of esternal wholesale funding 
rhodepp,        0.9135, , ,   beta_pdf,       0.8, 0.05;      //persistence of private sector deposit 
rhonw,          0.9178, , ,   beta_pdf,       0.8, 0.05;      //persistence of networth 
sbank,          0.0387, , ,   gamma_pdf,      0.20, 0.15;     //retained profit faction that increase networth
psibank,        0.0091, , ,   gamma_pdf,      0.20, 0.15;     //sensitivity of endegenous premium to leverage (funding-networth) 
rhobglob,       0.7586, , ,   beta_pdf,       0.8, 0.05;      //persistence of exegenous global premium 
*/

sigmasch,       2.1325, , ,   inv_gamma_pdf,  2, 1;           //standard error, credit to households
sigmascf,       1.5714, , ,   inv_gamma_pdf,  2, 1;           //standard error, credit to firms
sigmascg,      10.2558, , ,   inv_gamma_pdf,  10, 5;          //standard error, lending to government
sigmaoa,        4.1458, , ,   inv_gamma_pdf,  4, 2;           //standard error, other assets of banks
sigmaloan,     10.4943, , ,   inv_gamma_pdf,  12, 6;          //standard error, external funding shock
sigmadepp,      1.8194, , ,   inv_gamma_pdf,  2, 1;           //standard error, private sector deposit shock 
sigmanet,       2.4293, , ,   inv_gamma_pdf,  3.8, 1.9;       //standard error, networth shock
sigmabglob,     0.0560, , ,   inv_gamma_pdf,  0.1, 0.05;      //standard error, exegenous global premium 

//global economy 
/*
thetarf,        0.8195, , ,   beta_pdf,       0.75, 0.1;      //foreign mp, interest rate smoothing
thetapif,       1.4835, , ,   normal_pdf,     1.5, 0.1;       //foreign mp, inflation response
thetavf,        0.2772, , ,   gamma_pdf,      0.25, 0.1;      //foreign mp, output gap response
phivf,          0.9126, , ,   beta_pdf,       0.80, 0.05;     //calvo, global value added price
xivf,           0.3741, , ,   beta_pdf,       0.50, 0.2;      //indexation, global value added price
psicf,          0.2830, , ,   beta_pdf,       0.25, 0.15;     //global habit formation parameter
epsiloncf,      1.5567, , ,   gamma_pdf,      1.0, 0.5;       //global crra
epsilonlf,      0.6335, , ,   gamma_pdf,      1.0, 0.5;       //global labour elasticity
*/

/*
rhocf,          0.8137, , ,   beta_pdf,       0.95, 0.02;      //persistence parameter, global consumption
rhorf,          0.7905, , ,   beta_pdf,       0.95, 0.02;      //persistence parameter, global monetary policy
rhopxf,         0.9462, , ,   beta_pdf,       0.95, 0.02;      //persistence parameter, global export price
rhozf,          0.9519, , ,   beta_pdf,       0.95, 0.02;    //persistence parameter, global trade
rhokappaf,      0.9694, , ,   beta_pdf,       0.95, 0.02;    //persistence parameter, export preference
*/

sigmarf,        0.1026, , ,   inv_gamma_pdf,  0.1, 0.05;      //standard error, global monetary policy
sigmacf,        1.9337, , ,   inv_gamma_pdf,  0.5, 0.5;      //standard error, global consumption preference
sigmamuvf,      0.1528, , ,   inv_gamma_pdf,  0.5, 0.5;      //standard error, global value added price markup
sigmapxf,       1.4429, , ,   inv_gamma_pdf,  0.5, 0.5;      //standard error, global export price markup
sigmazf,        1.6301, , ,   inv_gamma_pdf,  0.5, 0.2;      //standard error, global trade
sigmakappaf,    2.6024, , ,   inv_gamma_pdf,  0.5, 0.2;      //standard error, (global) export preference

//domestic energy price
//rhope,        0.9900, , ,   beta_pdf,       0.9, 0.05;      //persistence parameter, domestic energy price (fixed)
sigmape,        5.5681, , ,   inv_gamma_pdf,  5.1, 2.55;      //standard error, global energy price


//global commodity price 
//rhopcomf,     0.9500, , ,   beta_pdf,       0.85, 0.05;     //persistence of global commodity price (fixed)
sigmapcomf,     7.6559, , ,   inv_gamma_pdf,  7.6, 3.80;      //standard error, global commodity price
//phimuvf,        0.0036, , ,   gamma_pdf,      0.01, 0.005;    //sensitivity of global value added price to commodity price
//phimuv,         0.0108, , ,   gamma_pdf,      0.01, 0.005;    //sensitivity of final output marginal cost to commodity price

phimuz,          0.05, , ,   inv_gamma_pdf,      0.05, inf; 
phimuv,          0.05, , ,   inv_gamma_pdf,      0.05, inf;
phimux,          0.05, , ,   inv_gamma_pdf,      0.05, inf;
phimum,          0.05, , ,   inv_gamma_pdf,      0.05, inf;
phimuxf,         0.05, , ,   inv_gamma_pdf,      0.05, inf;
phimuvf,         0.05, , ,   inv_gamma_pdf,      0.05, inf;

//measurement errors
sigmamec,       0.8345, , ,   inv_gamma_pdf,  0.5, inf;       //standard error of observable household consumption 
sigmamei,       3.9137, , ,   inv_gamma_pdf,  0.5, inf;       //standard error of observable business investment
sigmameg,       0.5009, , ,   inv_gamma_pdf,  0.5, inf;       //standard error of observable government soending
sigmamex,       1.9004, , ,   inv_gamma_pdf,  0.5, inf;       //standard error of observable exports
sigmamem,       3.0961, , ,   inv_gamma_pdf,  0.5, inf;       //standard error of observable imports

end;

varobs
  dlnv_t	dlnc_t dlng_t dlni_t  dlnx_t dlnm_t	dlnl_t	piw_t	pic_t	corepic_t pie_t	dlnpx_t	pim_t dlne_t	r_t	spread_t  
  dlnzf_t	dlnvf_t	pixf_t	picf_t	rf_t	
  dlntr_t dlntxh_t dlntxf_t dlnntx_t dlncg_t dlnig_t 
  dlncreditf_t dlncredith_t dlnlendg_t dlnnetworth_t dlnloan_t dlndepp_t 
  pipcomf_t
;
 

//estimated_params_init(use_calibration);  
//end; 

//model estimation
estimation (datafile = datatempo, xls_sheet = Sheet2,   
  first_obs = 40, nobs = 100, 
  mode_compute = 0, //load_mh_file, mode_file = tempo1_mh_mode,
  mode_file = tempo1f_mode, //tempo1_mean
  mh_replic = 0, //39999, mh_nblocks = 2, 
  //mh_tune_jscale = 0.33, //
  mh_jscale = 0.33536, // rhos and sigma only
  //mh_jscale = 0.16679, //all parameteres
  mh_drop = 0.25, //mode_check, 
  smoother, //moments_varendo, 
  nograph,
  plot_priors = 0
  ) 
  dlnvann_t dlncann_t dlniann_t dlngann_t dlnxann_t dlnmann_t vgap_t vtrendgap_t picann_t corepicann_t rann_t
  dlnzfann_t dlnvfann_t vgapf_t picfann_t rfann_t 
;

/*
//conditional forecasting
conditional_forecast_paths;

  var r_t;          
  periods 1 2 3 4 5 6 7 8;   
  values  -0.0625	-0.0625	-0.0625	-0.0625	-0.0625	-0.0625	-0.0625	-0.0625; 
  
  var spread_t;
  periods 1 2 3 4 5 6 7 8;
  values -0.0325	-0.0325	-0.0325	-0.0325	-0.0325	-0.0325	-0.0325	-0.0325;
  
  var dlne_t;
  periods 1 2 3 4 5 6 7 8;   
  values 0.4988	0.4988	0.4988	0.4988	0.4988	0.4988	0.4988	0.4988;

  var pie_t;
  periods 1 2 3 4 5 6 7 8; 
  values  -0.5000	-0.5000	-0.5000	-0.5000	-0.5000	-0.5000	-0.5000	-0.5000;

  var dlnzf_t;
  periods 1 2 3 4 5 6 7 8;
  values -0.3971	-0.1934	-0.0231	-0.1795	-0.0734	-0.0921	-0.1033	-0.3322; 
  
  var dlnvf_t;
  periods 1 2 3 4 5 6 7 8;
  values  0.0399	0.0198	0.0224	0.0299	-0.0338	-0.0595	-0.0949	-0.0305;
 
  var dlng_t; 
  periods 1 2 3 4 5 6 7 8;
  values -0.7689	0.4154	-0.3443	-0.0949	0.0102	-0.1774	-0.0663	-0.0978;

  var dlnl_t;
  periods 1 2 3 4 5 6 7 8;
  values -0.0012	-0.0012	-0.0012	-0.0012	-0.0012	-0.0012	-0.0012	-0.0012;  
  
  var piw_t;
  periods 1 2 3 4 5 6 7 8;
  values -0.7503	-0.7503	-0.7503	-0.7503	-0.7503	-0.7503	-0.7503	-0.7503; 
 
end;

conditional_forecast(
  parameter_set = posterior_mean, 
  controlled_varexo = (etar_t etanet_t etabf_t etape_t etazf_t  etacf_t etag_t etal_t etamuw_t),// 
  periods = 8,
  replic = 10000,
  conf_sig = 0.9 
); 

plot_conditional_forecast(periods = 8) 
   vgap_t vtrendgap_t dlnvann_t dlncann_t dlniann_t dlngann_t dlnxann_t dlnmann_t picann_t corepicann_t rann_t q_t;
*/


//shock decomposition group
shock_groups(name=group1); 

  'Global demand' = etacf_t etarf_t etakappaf_t etazf_t;
      //'global consumption preference' = etacf_t;
      //'global monetary policy' = etarf_t;
      //'global demand' = etazf_t;
      //'export preference' = etakappaf_t;

  'Global cost' = etamuvf_t etapxf_t etapcomf_t;
      //'global price markup' = etamuvf_t;
      //'global export price' = etapxf_t;
      //'Global commodity' = etapcomf_t;

  'Domestic demand' =  etac_t etai_t etam_t;  
      //'consumption preference' = etac_t;
      //'investment adjustment' = etai_t;
      //'import preference' = etam_t;
      
  'Domestic cost' = etamuz_t etamuztemp_t etamuv_t etamux_t etamum_t etamuw_t; 
      //'final price markup' = etamuz_t;
      //'temporary final output price markup' = etamuztemp_t;
      //'value added markup' = etamuv_t;
      //'export price markup' = etamux_t;
      //'import price markup' = etamum_t;
      //'wage markup' = etamuw_t;
      
  'Energy price' = etape_t;

  'Supply & productivity' = etatfp_t etalap_t etal_t etaomegaf_t etanonl_t;
      //'total factor productivity' = etatfp_t;
      //'labour-augmenting productivity' = etalap_t;
      //'labour hour' = etal_t;
      //'relative productivity' = etaomegaf_t;
      //'labour hour trend' = etanonl_t;

  'Monetary condition' = etar_t etabf_t;
      //'Unsystematic MP' = etar_t;
      //'External risk premium' = etabf_t;

  'Fiscal policy' = etag_t etaig_t etatr_t etatxh_t etatxf_t etantx_t etad_t;
      //'government revenue' = etatxh_t etatxf_t etantx_t;
      //'government spending' = etag_t etacg_t etaig_t etatr_t etad_t;
      //'government spending' = etag_t etacg_t;
      //'government investment' = etaig_t;
      //'government transfer' = etatr_t;
      //'government tax household' = etatxh_t;
      //'government tax firm' = etatxf_t;
      //'government non tax revenue' = etantx_t;
      //'soft budeget' = etad_t;

  'Risk premium' =  etanet_t etabglob_t ; 
      //'global premium' = etabg_t; 
      //'banking networth' = etanet_t;
      
  'Banking sector' = etaloan_t etadepp_t  etaoa_t etasch_t etascf_t etascg_t ;  
      //'external loans' = etaloan_t; 
      //'private deposit' = etadepp_t;
      //'credit to household' = etasch_t;
      //'credit to firm' = etascf_t;
      //'lending to government' = etascg_t;
      //'other assets' = etaoa_t;
      
  'Other factors' = mec_t mei_t meg_t mex_t mem_t; 
  
end;


//historical shock decomposition
shock_decomposition (
  use_shock_groups = group1,
  parameter_set =  posterior_mode,  
  first_obs = 112, nobs = 36, 
  //first_obs = 108, nobs = 40, 
  datafile = datatempo, xls_sheet = Sheet2,
  nograph) vgap_t vtrendgap_t 
  dlnvann_t dlncann_t dlniann_t dlngann_t dlnxann_t dlnmann_t picann_t corepicann_t rann_t q_t 
  //dlnzfann_t  dlnvfann_t  vgapf_t picfann_t rfann_t  
;
  
plot_shock_decomposition(realtime = 0, vintage=0, steadystate, use_shock_groups = group1, write_xls) 
  //vgap_t vtrendgap_t 
  dlnvann_t //dlncann_t dlniann_t dlngann_t dlnxann_t dlnmann_t 
  picann_t corepicann_t //rann_t q_t
  ; 


/*
//real time shock decomposition
realtime_shock_decomposition (
  use_shock_groups = group1,
  parameter_set =  posterior_mode, 
  first_obs = 112, nobs = 36, 
  datafile = datatempo1b,
  save_realtime = [147], 
  forecast = 8
  ) 
  vgap_t vtrendgap_t dlnvann_t dlncann_t dlniann_t dlngann_t dlnxann_t dlnmann_t picann_t corepicann_t rann_t q_t 
  //dlnzfann_t  dlnvfann_t  vgapf_t picfann_t rfann_t  
;

plot_shock_decomposition(realtime = 3, vintage=0, write_xls, use_shock_groups = group1, steadystate) 
  vgap_t vtrendgap_t dlnvann_t dlncann_t dlniann_t dlngann_t dlnxann_t dlnmann_t picann_t corepicann_t rann_t q_t; 
*/

/*
//wrtting forecasts to excell file
//real GDP and its components
xlswrite('Book1', 'Real GDP', 'FCST', 'A3')
xlswrite('Book1', oo_.SmoothedVariables.dlnvann_t', 'FCST', 'B3')
xlswrite('Book1', 'Household consumption', 'FCST', 'A4')
xlswrite('Book1', oo_.SmoothedVariables.dlncann_t', 'FCST', 'B4')
xlswrite('Book1', 'Business investment', 'FCST', 'A5')
xlswrite('Book1', oo_.SmoothedVariables.dlniann_t', 'FCST', 'B5')
xlswrite('Book1', 'Government spending', 'FCST', 'A6')
xlswrite('Book1', oo_.SmoothedVariables.dlngann_t', 'FCST', 'B6')
xlswrite('Book1', 'Exports', 'FCST', 'A7')
xlswrite('Book1', oo_.SmoothedVariables.dlnxann_t', 'FCST', 'B7')
xlswrite('Book1', 'Imports', 'FCST', 'A8')
xlswrite('Book1', oo_.SmoothedVariables.dlnmann_t', 'FCST', 'B8')

//headline inflation and its components
xlswrite('Book1', 'Headline inflation', 'FCST', 'A10')
xlswrite('Book1', oo_.SmoothedVariables.picann_t', 'FCST', 'B10')
xlswrite('Book1', 'Core inflation', 'FCST', 'A11')
xlswrite('Book1', oo_.SmoothedVariables.corepicann_t', 'FCST', 'B11')
xlswrite('Book1', 'Energy price', 'FCST', 'A12')
xlswrite('Book1', oo_.SmoothedVariables.pieann_t', 'FCST', 'B12')
xlswrite('Book1', 'Temporary inflation', 'FCST', 'A13')
xlswrite('Book1', oo_.SmoothedVariables.muztempann_t', 'FCST', 'B13')

//output gap
xlswrite('Book1', 'Price sticky-flexi gap', 'FCST', 'A16')
xlswrite('Book1', oo_.SmoothedVariables.vgap_t', 'FCST', 'B16')
xlswrite('Book1', 'Production trend gap', 'FCST', 'A17')
xlswrite('Book1', oo_.SmoothedVariables.vtrendgap_t', 'FCST', 'B17')

//federal government
xlswrite('Book1', 'Fed Gov consumption', 'FCST', 'A20')
xlswrite('Book1', oo_.SmoothedVariables.dlncgann_t', 'FCST', 'B20')
xlswrite('Book1', 'Fed Gov investment', 'FCST', 'A21')
xlswrite('Book1', oo_.SmoothedVariables.dlnigann_t', 'FCST', 'B21')
*/







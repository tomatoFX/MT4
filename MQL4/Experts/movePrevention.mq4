//+------------------------------------------------------------------+
//|                                               movePrevention.mq4 |
//|                                                               JT |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "JT"
#property link      ""
#property version   "1.00"
#property strict
//--- input parameters
input int      startPreventionPoint=50;
input int      preventionPoint=10;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
//   EventSetTimer(60);
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
    for(int i=0;i<OrdersTotal();i++)//移动止损通用代码,次代码会自动检测buy和sell单并对其移动止损
         {
            if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
              {
                if(OrderType()==OP_BUY && OrderSymbol()==Symbol())
                  {
                     if((Bid-OrderOpenPrice())>=Point*startPreventionPoint)
                      {
                         if(OrderStopLoss()<(Bid-Point*preventionPoint) || (OrderStopLoss()==0))
                           {
                              OrderModify(OrderTicket(),OrderOpenPrice(),Bid-Point*preventionPoint,OrderTakeProfit(),0,Green);
                           }
                      }      
                  }
                if(OrderType()==1 && OrderSymbol()==Symbol())
                  {
                    if((OrderOpenPrice()-Ask)>=(Point*startPreventionPoint))
                      {
                         if((OrderStopLoss()>(Ask+Point*preventionPoint)) || (OrderStopLoss()==0))
                           {
                              OrderModify(OrderTicket(),OrderOpenPrice(),Ask+Point*preventionPoint,OrderTakeProfit(),0,Green);
                           }
                      }
                  }
              }
         }
  }
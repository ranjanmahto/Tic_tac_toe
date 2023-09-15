



import 'package:flutter/material.dart';
import 'package:tic_tac_toe_ai/button.dart';
import 'package:tic_tac_toe_ai/customdialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   var player1;
   var player2;
  List<Button> buttonlist=  List.empty();
  int activeplayer=1;
  @override
  void initState()
  {
    super.initState();
    buttonlist= createlist();

  }

  List<Button> createlist()
  {
    activeplayer=1;
    player1= <int>[];
    player2= <int>[];
     var buttons= <Button> [

      Button(id: 1),

      Button(id: 2),
      Button(id: 3),
      Button(id: 4),
      Button(id: 5),
      Button(id: 6),
      Button(id: 7),
      Button(id: 8),
      Button(id: 9),
     ];
     return buttons;
  }

  void playgame(Button b)
  {
     setState(() {
       if(activeplayer==1)
       {
        
        b.text= 'X';
        
        player1.add(b.id);
        activeplayer=2;
       }
       else{
        
        b.text= '0';
        
        player2.add(b.id);
        
        activeplayer=1;

       }
       b.enabled= false;
       int winner= checkwinner();
      if(buttonlist.every((p) => p.text!="") && winner==-1)
      {
        showDialog(context: context,
         builder: (_)=> CustomDialog(title: "Game Tied", content: 'Press the reset Button to start the game.', callback: reset));
      }
      else if(winner==-1 && activeplayer==2)
      {
           

         playcomputer();
      }
     });
  }

  playcomputer()
  {
      var result= minimax(player1,player2,"ai");
      int i=  buttonlist.indexWhere((p)=> p.id == (result.index));
      
      playgame(buttonlist[i]);

  }
  bool winning(List p)
  {
    if((p.contains(1) && p.contains(2) && p.contains(3)) ||
    (p.contains(4) && p.contains(5) && p.contains(6)) ||
    (p.contains(7) && p.contains(8) && p.contains(9)) ||
    (p.contains(1) && p.contains(4) && p.contains(7)) ||
    (p.contains(2) && p.contains(5) && p.contains(8)) ||
    (p.contains(3) && p.contains(6) && p.contains(9)) ||
    (p.contains(1) && p.contains(5) && p.contains(9)) ||
    (p.contains(3) && p.contains(5) && p.contains(7)) )
    {
        return true;
    }
    else{
      return false;
    }
  }
   List emptyindices(List p1, List p2)
   {
     var emptycells= <int>[];
      var list= List.generate(9, (i) => i+1);
      for(var cellid in list)
      {
        if(!(p1.contains(cellid) || p2.contains(cellid)))
        {
          emptycells.add(cellid);
        }
      }

      return emptycells;
   }
   Indices minimax(List p1,List p2,String player)
   {
    var available= emptyindices(p1,p2);
    if(winning(p1))
    {
      var r= Indices();
      r.index=0;
      r.score= -10;
      return  r;
    }
    else if(winning(p2))
    {
        var r= Indices();
      r.index=0;
      r.score= 10;
      return  r;
    }
    else if(available.isEmpty)
    {
      var r= Indices();
      r.index=0;
      r.score= 0;
      return  r;
    }
    var moves = [];

    for(int i=0;i<available.length;i++)
    {
      var move= Indices();
      move.index= available[i];
      if(player== "human")
      {

        p1.add(available[i]);
        var result= minimax(p1, p2, "ai");
        move.score= result.score;
        p1.remove(available[i]);
      }
      else
      {
        p2.add(available[i]);
        var result= minimax(p1, p2, "human");
        move.score= result.score;
        p2.remove(available[i]);
      }
      moves.add(move);

    }
    var bestmove=0;
    if(player=="ai")
    {
      var bestscore= -10000;
      for(int i=0;i<moves.length;i++)
      {
        if(moves[i].score > bestscore)
        {
          bestscore= moves[i].score;
          bestmove=i;
        }
      }
    }
    else
    {
      var bestscore= 10000;
      for(int i=0;i<moves.length;i++)
      {
        if(moves[i].score < bestscore)
        {
          bestscore= moves[i].score;
          bestmove=i;
        }
      }
    }

    return moves[bestmove];

  }
 checkwinner()
 {
  int winner=-1;

   if(player1.contains(1)&& player1.contains(2)&&player1.contains(3))
   {
     winner=1;
   }
  else if(player1.contains(4)&& player1.contains(5)&&player1.contains(6))
   {
     winner=1;
   }
   else if(player1.contains(7)&& player1.contains(8)&&player1.contains(9))
   {
     winner=1;
   }
   else if(player1.contains(1)&& player1.contains(7)&&player1.contains(4))
   {
     winner=1;
   }
   else if(player1.contains(2)&& player1.contains(5)&&player1.contains(8))
   {
     winner=1;
   }
   else if(player1.contains(3)&& player1.contains(6)&&player1.contains(9))
   {
     winner=1;
   }
   else if(player1.contains(1)&& player1.contains(5)&&player1.contains(9))
   {
     winner=1;
   }
   else if(player1.contains(3)&& player1.contains(5)&&player1.contains(7))
   {
     winner=1;
   }
  else if(player2.contains(1)&& player2.contains(2)&&player2.contains(3))
   {
     winner=2;
   }
  else if(player2.contains(4)&& player2.contains(5)&&player2.contains(6))
   {
     winner=2;
   }
   else if(player2.contains(7)&& player2.contains(8)&&player2.contains(9))
   {
     winner=2;
   }
   else if(player2.contains(1)&& player2.contains(7)&&player2.contains(4))
   {
     winner=2;
   }
   else if(player2.contains(2)&& player2.contains(5)&&player2.contains(8))
   {
     winner=2;
   }
   else if(player2.contains(3)&& player2.contains(6)&&player2.contains(9))
   {
     winner=2;
   }
   else if(player2.contains(1)&& player2.contains(5)&&player2.contains(9))
   {
     winner=1;
   }
   else if(player2.contains(3)&& player2.contains(5)&&player2.contains(7))
   {
     winner=1;
   }
    
   if(winner==1)
   {
    
    showDialog(context: context, builder: (_)=>CustomDialog(title: "Player 1 won",content: "Press the reset button to start the game",callback: reset,));
   }
   else if(winner==2)
   {
    
    showDialog(context: context, builder: (_)=>CustomDialog(title: "Player 2 won",content: "Press the reset button to start the game",callback:reset));
   }
   return winner;
 }
 void reset()
 {
  setState(() {
    
      if(Navigator.canPop(context))
      {
        Navigator.pop(context);
        
      
      }
      activeplayer=1;
      buttonlist= createlist();

    
    
  });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child:  Text('Tic tac toe',style: TextStyle(fontSize: 25,color: Colors.white),)),
      backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.teal,
      body:Column(
      
      
      children: [

        
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            color: Colors.black,
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
                  gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: (0.6/0.499999),
            crossAxisSpacing: 7,
            mainAxisSpacing: 7
            
                  ),
                  itemCount: buttonlist.length ,
                 itemBuilder: (context,i){
                 return InkWell(
                   onTap: buttonlist[i].enabled?()=> {playgame(buttonlist[i])}:null,
                   
                   splashColor: Colors.black,
                   child: Container(
                        
                       decoration:  BoxDecoration(
                        
                         gradient: LinearGradient(colors: [Colors.teal,Colors.teal],begin: Alignment.bottomLeft,end: Alignment.topRight),
                         
                       ),
                       child: Center(child: Text(buttonlist[i].text, style: const TextStyle(fontSize: 30,color:Colors.white))),
                   ),
                 );
            
                 }),
          ),
        ),
        SizedBox(height: 100,),
      SizedBox(
        height: 50,
        width: 250,
        child: ElevatedButton(onPressed: reset,    
        
        child: Text('Reset',style: TextStyle(fontSize: 30,color: Colors.teal,fontWeight: FontWeight.bold),),
        style: ElevatedButton.styleFrom(
        
          backgroundColor: Colors.white,
          
          
        ),
        
        ),
      )
      
      
      ],
        )
    );
    
  }
}

class Indices
{
   var index=0;
   var score=0;
}
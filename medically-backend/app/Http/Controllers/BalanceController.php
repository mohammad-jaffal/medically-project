<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;


class BalanceController extends Controller
{
     
    public function addBalance(Request $request){
        $userbalance = User::where('id','=',$request->user_id)->value('balance');
        $new = (int)$userbalance+(int)$request->balance;
        User::where('id', $request->user_id)->update(array('balance' => $new));

        return response()->json([
            "success" => true,
        ], 200);
    }

    public function transferBalance(Request $request){
        $userBalance = User::where('id','=',$request->user_id)->value('balance');
        $userNew = (int)$userBalance-(int)$request->balance;
        User::where('id', $request->user_id)->update(array('balance' => $userNew));

        $doctorBalance = User::where('id','=',$request->doctor_id)->value('balance');
        $doctorNew = (int)$doctorBalance+0.8*(int)$request->balance;
        User::where('id', $request->doctor_id)->update(array('balance' => $doctorNew));
        

        return response()->json([
            "success" => true,
        ], 200);
    }

    public function getBalance(Request $request){
        $balance = User::where('id','=',$request->user_id)->value('balance');
        
        return response()->json([
            "success" => true,
            "balance" => $balance,
        ], 200);
    }


}

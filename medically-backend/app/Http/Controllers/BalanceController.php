<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;


class BalanceController extends Controller
{
     
    public function addBalance(Request $request){
        $userbalance = User::where('id','=',$request->user_id)->value('balance');
        $new = (int)$userbalance+(int)$request->balance;
        \DB::table('users')->where('id', $request->user_id)->update(array('balance' => $new));

        

        return response()->json([
            "success" => $userbalance,
        ], 200);
    }
}

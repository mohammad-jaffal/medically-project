<?php

namespace App\Http\Controllers;
use App\Models\User;

use Illuminate\Http\Request;

class UserController extends Controller
{
    public function getAllUsers(Request $request){

        $users = User::where('type', 1)->get();

        return response()->json([
            "success" => true,
            "users" => $users
        ], 200);
    }

    public function getPendingUsers(Request $request){

        $users = User::where('type', 3)->get();

        return response()->json([
            "success" => true,
            "users" => $users
        ], 200);
    }

    public function changeImage(Request $request){

        $users = User::find($request->id)->update(array('profile_picture' => $request->image));

        return response()->json([
            "success" => true,
        ], 200);
    }
}

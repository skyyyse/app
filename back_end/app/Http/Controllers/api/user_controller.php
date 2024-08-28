<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class user_controller extends Controller
{
    public function index(){
        $user = auth()->user();
        return response()->json([
            "status"=>true,
            "user"=> $user,
        ]);
    }
}

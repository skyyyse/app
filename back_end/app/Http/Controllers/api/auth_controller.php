<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
class auth_controller extends Controller
{
    public function register(Request $request){
        $validate=validator::make($request->all(),[
            'name'=>'required|string',
            'email'=>'required|string',
            'password'=>'required',
        ]);
        if($validate->fails()){
            return response()->json([
                'create'=>false,
                "message" => $validate->errors()->all(),
            ]);
        }else{
            $user=User::create([
                'name'=>$request->name,
                'email'=>$request->email,
                'password' => Hash::make($request->password),
            ]);
            return response()->json([
                'data'=>$user,
                'token' => $user->createToken('secret')->plainTextToken
            ]);
        }
    }
    public function login(Request $request)
    {
        $attrs = $request->validate([
            'email'     => 'required',
            'password'  => 'required'
        ]);

        if (!Auth::attempt($attrs)) {
            return response([
                'message' => 'Invalid Credentials.'
            ], 403);
        }

        $user = User::where('email', $request['email'])->firstOrFail();

        return response([
            'user' => $user,
            'token' => $user->createToken('secret')->plainTextToken
        ], 200);
    }
    public function logout(Request $request){
        $request->user()->currentAccessToken()->delete();
        return response()->json([
            'message' => 'Successfully logged out',
        ]);
    }
    public function data(){
        $user=User::all();
        return response()->json(
            [
                'user'=>$user,
            ]
        );
    }
}

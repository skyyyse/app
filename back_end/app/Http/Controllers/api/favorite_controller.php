<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use App\Models\favorite;
use App\Models\post_model;
use Illuminate\Http\Request;

class favorite_controller extends Controller
{
    public function index(){
        $favorite=favorite::with('post')->with('user:id,image,name,email')->where('user_id',auth()->user()->id)->get();
        return response()->json([
            'favorite'=>$favorite,
            'status'=>true,
        ]);
    }
    public function favorite_unfavorite(Request $request){
        $post=post_model::find($request->id);
        if(!$post){
            return response()->json([
                'message'=>'not fount',
                'status'=>true,
            ]);
        }else{
            $favorite=$post->favorite()->where('user_id',Auth()->user()->id)->first();
            if(!$favorite){
                favorite::create([
                    'post_id'=>$request->id,
                    'user_id'=>Auth()->user()->id,
                ]);
                return response()->json([
                    'message'=>'favorite sucessfull',
                    'status'=>true,
                ]);
            }else{
                $favorite->delete();
                return response()->json([
                    'message'=>'unfavorite sucessfull',
                    'status'=>true,
                ]);
            }
        }
    }
}

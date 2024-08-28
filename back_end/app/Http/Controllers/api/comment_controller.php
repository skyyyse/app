<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use App\Models\comment_model;
use App\Models\post_model;
use Illuminate\Http\Request;

class comment_controller extends Controller
{
    public function index(Request $request){
        $post=post_model::find($request->id);
        if(!$post){
            return response()->json([
                'message'=>'not fount',
                'status'=>false,
            ]);
        }else{
            return response()->json([
                'comment'=>$post->Comment()->with('user:id,name,image,email')->get(),
                'status'=>false,
            ]);
        }
    }
    public function store(Request $request){
        $post=post_model::find($request->id);
        if(!$post){
            return response()->json([
                'message'=>'not fount',
                'status'=>false,
            ]);
        }else{
            $comment=comment_model::create([
                'comment'=>$request->comment,
                'user_id'=>Auth()->user()->id,
                'post_id'=>$request->id,
            ]);
            return response()->json([
                'comment'=>$post->Comment()->with('user:id,name,image,email')->get(),
                'status'=>true,
            ]);
        }
    }
    public function update(Request $request){
        $comment=comment_model::find($request->id);
        if(!$comment){
            return response()->json([
                'message'=>'not fount',
                'status'=>false,
            ]);
        }else{
            $comment->update([
                'comment'=>$request->comment,
            ]);
            return response()->json([
                'comment'=>"Update sucessfully",
                'status'=>true,
            ]);
        }
    }
    public function delete(Request $request){
        $comment=comment_model::find($request->id);
        if(!$comment){
            return response()->json([
                'message'=>'not fount',
                'status'=>false,
            ]);
        }else{
            $comment->delete();
            return response()->json([
                'comment'=>"Delete sucessfully",
                'status'=>true,
            ]);
        }
    }
}

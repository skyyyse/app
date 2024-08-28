<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class comment_model extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $table='comment';
    protected $primaryKey='id';
    protected $fillable=[
        'comment',
        'user_id',
        'post_id',
    ];
    public function user(){
        return $this->belongsTo(User::class);
    }
}

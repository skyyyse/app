<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class like_model extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $table='like';
    protected $primaryKey='id';
    protected $fillable=[
        'user_id',
        'post_id',
    ];
}

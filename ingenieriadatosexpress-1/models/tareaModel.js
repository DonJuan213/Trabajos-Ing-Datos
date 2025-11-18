const mongoose = require('mongoose');

//definir Schema
const tareaSchema = new mongoose.Schema({
    titulo: {
        type: String,
        required: true,
        trim: true,
        minlength: 3,
        maxlength: 100
    },
    descripcion: {
        type: String,
        required: true,
        trim: true,
        minlength: 3,
        maxlength: 500
    },
    prioridad:{
        type: String,
        enum: ['baja', 'media', 'alta'],
        default: 'media',  
        message: '{VALUE} no es una prioridad válida'
    },
    categoria:{
        type: String,
        enum: ['trabajo', 'personal', 'estudios', 'otros'],
        default: 'otros',
        message: '{VALUE} no es una categoría válida'
    },
    estado:{
        type: String,
        enum: ['pendiente', 'en progreso', 'completada'],
        default: 'pendiente',
        message: '{VALUE} no es un estado válido'
    },
    fetchedAt:{
        type: Date,
        default: Date.now
    }
});

tareaSchema.statics.obtenerEstadisticas=async function(){
    const total_tareas= await this.countDocuments();
    const tareas_completadas= await this.countDocuments({estado:"completada"});
    const tareas_pendientes= total_tareas-tareas_completadas;
    return{
        total_tareas,
        tareas_completadas,
        tareas_pendientes
    };
};

tareaSchema.statics.obtenerPorPrioridad=async function (prioridad){
    return this.find({prioridad});
};

tareaSchema.methods.reabrir=async function(){
    this.estado = "pendiente";
    this.fetchedAt = Date.now();
    return this;
};

tareaSchema.methods.completar=async function(){
    this.estado = "completada";
    this.fetchedAt = Date.now();
    return this;
};






//accesos a datos repositories

module.exports = mongoose.model('Tarea', tareaSchema);

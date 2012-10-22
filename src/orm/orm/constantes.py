# -*- coding: utf-8 -*-

codigos_de_error = ["OK", "Privilegios insuficientes", "Accion imposible"]
privilegios = ["Todos", "Ninguno"]
idiomas = ["Espanol", "English", "Francais", "Deutsch", "Mandarin"]
tipos_de_codigo = ["GTIN-13", "GTIN-8", "GTIN-14", "GS1-128", "Otro"]
sexos = ["Hombre", "Mujer"]
grados_de_instruccion = [
    {'grado': 1, 'instruccion': "Primaria"},
    {'grado': 2, 'instruccion': "Secundaria"},
    {'grado': 3, 'instruccion': "Tecnico Medio"},
    {'grado': 4, 'instruccion': "Tecnico Superior"},
    {'grado': 5, 'instruccion': "Universitario"},
    {'grado': 6, 'instruccion': "Especializacion"},
    {'grado': 7, 'instruccion': "Maestria"},
    {'grado': 8, 'instruccion': "Doctorado"}
]
visibilidades = [
    "Ninguno visible", "Cantidad visible", "Precio visible", "Ambos visibles"
]
acciones = [
    "Insertar", "Abrir", "Actualizar", "Eliminar", "Bloquear", "Abrir sesion",
    "Cerrar sesion"
]
calificaciones = ["Bien", "Mal"]
grupos_de_edades = [
    "Adolescentes", "Adultos jovenes", "Adultos maduros", "Adultos mayores",
    "Tercera edad"
]
estatus = ["Activo", "Bloqueado", "Eliminado"]
dias = [
    {'orden': 1, 'nombre': "Lunes"},
    {'orden': 2, 'nombre': "Martes"},
    {'orden': 3, 'nombre': "Miercoles"},
    {'orden': 4, 'nombre': "Jueves"},
    {'orden': 5, 'nombre': "Viernes"},
    {'orden': 6, 'nombre': "Sabado"},
    {'orden': 7, 'nombre': "Domingo"}
]
arbol_categorias = [
    {
        'nombre': 'Libros', 
        'hijos': [
            {'nombre': 'Noavelas', 'hijos': [] },
            {'nombre': 'Poesia', 'hijos': [] },
            {'nombre': 'Tecnicos', 'hijos': [] },
            {'nombre': 'Negocios', 'hijos': [] },
            {'nombre': 'Cocina', 'hijos': [] }
        ] 
    },
    {
        'nombre': 'Computacion - Electronica', 
        'hijos': [
            {'nombre': 'Instrumentos musicales', 'hijos': [] },
            {'nombre': 'Consolas de videojuegos', 'hijos': [] },
            {'nombre': 'Juegos de video', 'hijos': [] },
            {'nombre': 'Procesadores', 'hijos': [] },
            {'nombre': 'Tarjetas madres', 'hijos': [] },
            {'nombre': 'Discos duros', 'hijos': [] },
            {'nombre': 'Camaras fotograficas', 'hijos': [] },
            {'nombre': 'Camaras de video', 'hijos': [] },
            {'nombre': 'Telefonos celulares', 'hijos': [] },
            {'nombre': 'Computadoras de escritorio', 'hijos': [] },
            {'nombre': 'Computadoras portatiles', 'hijos': [] },
        ]
    },
    {
        'nombre': 'Alimentos - Hogar', 
        'hijos': [
            {'nombre': 'Canasta basica', 'hijos': [] },
            {'nombre': 'Limpieza', 'hijos': [] },
            {'nombre': 'Aseo Personal', 'hijos': [] },
            {'nombre': 'Viveres', 'hijos': [] },
            {'nombre': 'Carnes', 'hijos': [] },
            {'nombre': 'Enlatados', 'hijos': [] },
        ] 
    },
    {
        'nombre': 'Juguetes - Ninos', 
        'hijos': [
            {'nombre': 'Peluches', 'hijos': [] },
            {'nombre': 'Figuras de accion', 'hijos': [] },
            {'nombre': 'Munecas', 'hijos': [] },
            {'nombre': 'Trenes', 'hijos': [] },
            {'nombre': 'Aviones', 'hijos': [] },
        ] 
    },
    {
        'nombre': 'Ropa - Calzado', 
        'hijos': [
            {'nombre': 'Ropa para damas', 'hijos': [] },
            {'nombre': 'Ropa para caballeros', 'hijos': [] },
            {'nombre': 'Calzado para damas', 'hijos': [] },
            {'nombre': 'Calzado para caballeros', 'hijos': [] },
        ] 
    },
    {
        'nombre': 'Deportes - Aire libre', 
        'hijos': [
            {'nombre': 'Futbol', 'hijos': [] },
            {'nombre': 'Baloncesto', 'hijos': [] },
            {'nombre': 'Tenis', 'hijos': [] },
            {'nombre': 'Rugby', 'hijos': [] },
            {'nombre': 'Beisbol', 'hijos': [] },
            {'nombre': 'Montanismo', 'hijos': [] },
        ] 
    },
    {
        'nombre': 'Ferreterias', 
        'hijos': [
           {'nombre': 'Herramientas electricas', 'hijos': [] },
           {'nombre': 'Construccion', 'hijos': [] },
           {'nombre': 'Herramientas manuales', 'hijos': [] },
           {'nombre': 'Pinturas', 'hijos': [] },
           {'nombre': 'Lamparas', 'hijos': [] },
           {'nombre': 'Electricidad', 'hijos': [] },
        ] 
    },
    {
        'nombre': 'Automotriz - Industrial', 
        'hijos': [
            {'nombre': 'Motores', 'hijos': [] },
            {'nombre': 'Alternadores', 'hijos': [] },
            {'nombre': 'Autoperiquitos', 'hijos': [] },
            {'nombre': 'Baterias', 'hijos': [] },
        ] 
    },
    {'nombre': 'No asignada', 'hijos': [] }
]
puntos_venezuela = [
    [5.178482,-60.688477], [4.937724,-60.578613], [4.67498,-60.864258], 
    [4.499762,-60.974121], [4.54357,-61.303711], [4.455951,-61.259766],
    [4.390229,-61.501465], [4.258768,-61.743164], [4.127285,-61.918945], 
    [4.105369,-62.116699], [4.171115,-62.468262], [4.017699,-62.709961],
    [3.710782,-62.731934], [3.623071,-62.973633], [3.93002,-63.215332], 
    [3.973861,-63.413086], [3.864255,-63.479004], [3.93002,-63.632812],
    [3.951941,-63.830566], [3.842332,-63.984375], [4.105369,-64.116211], 
    [4.127285,-64.555664], [4.258768,-64.819336], [3.776559,-64.489746],
    [3.623071,-64.182129], [3.469557,-64.248047], [3.184394,-64.204102], 
    [2.723583,-63.984375], [2.482133,-64.072266], [2.416276,-63.391113],
    [2.196727,-63.369141], [1.955187,-63.984375], [1.647722,-64.072266], 
    [1.428075,-64.379883], [1.493971,-64.401855], [1.252342,-64.709473],
    [1.120534,-65.01709], [1.120534,-65.148926], [0.900842,-65.214844], 
    [0.922812,-65.324707], [0.659165,-65.522461], [0.98872,-65.522461],
    [0.966751,-65.786133], [0.812961,-66.027832], [0.747049,-66.269531], 
    [1.186439,-66.84082], [2.262595,-67.192383], [2.767478,-67.587891],
    [2.855263,-67.851562], [3.316018,-67.346191], [3.754634,-67.478027], 
    [3.732708,-67.565918], [4.236856,-67.785645], [4.412137,-67.763672],
    [4.54357,-67.82959], [4.981505,-67.785645], [5.266008,-67.851562], 
    [5.50664,-67.609863], [5.747174,-67.631836], [6.009459,-67.368164],
    [6.227934,-67.5], [6.293459,-67.82959], [6.184246,-67.983398], 
    [6.118708,-68.532715], [6.20609,-69.060059], [6.053161,-69.257812],
    [6.09686,-69.411621], [6.926427,-70.070801], [6.904614,-70.268555], 
    [7.057282,-70.576172], [7.057282,-70.905762], [6.948239,-71.015625],
    [7.013668,-72.004395], [7.340675,-72.158203], [7.427837,-72.443848], 
    [7.993957,-72.443848], [8.015716,-72.355957], [8.363693,-72.37793],
    [8.602747,-72.641602], [9.123792,-72.773437], [9.264779,-73.037109], 
    [9.18887,-73.344727], [9.838979,-72.927246], [9.903921,-72.971191],
    [10.401378,-72.905273], [11.070603,-72.487793], [11.135287,-72.251587], 
    [11.641476,-71.971436], [11.840471,-71.328735], [11.732924,-71.367187],
    [11.593051,-71.954956], [11.275387,-71.905518], [10.984335,-71.586914], 
    [10.984335,-71.773682], [10.736175,-71.641846], [10.660608,-71.575928],
    [10.466206,-71.619873], [10.09867,-71.905518], [9.828154,-72.125244], 
    [9.665738,-72.015381], [9.503244,-71.993408], [9.373193,-71.71875],
    [9.058702,-71.71875], [9.134639,-71.268311], [9.351513,-71.05957], 
    [9.838979,-71.092529], [10.325728,-71.466064], [10.790141,-71.5979],
    [10.822515,-71.444092], [10.898042,-71.422119], [10.941192,-71.520996], 
    [11.18918,-70.85083], [11.501557,-70.070801], [11.415418,-69.807129],
    [11.480025,-69.719238], [11.673755,-69.807129], [11.587669,-70.202637], 
    [11.845847,-70.3125], [12.082296,-70.224609], [12.189704,-70.026855],
    [12.103781,-69.873047], [11.759815,-69.763184], [11.480025,-69.631348], 
    [11.523088,-69.23584], [11.415418,-68.840332], [11.156845,-68.422852],
    [10.876465,-68.203125], [10.790141,-68.291016], [10.509417,-68.126221], 
    [10.617418,-67.016602], [10.617418,-66.335449], [10.649811,-66.236572],
    [10.563422,-66.027832], [10.509417,-66.115723], [10.077037,-65.192871], 
    [10.141932,-64.6875], [10.401378,-64.182129], [10.466206,-63.676758],
    [10.574222,-64.27002], [10.660608,-63.808594], [10.682201,-63.215332], 
    [10.746969,-62.753906], [10.682201,-62.270508], [10.703792,-61.896973],
    [10.552622,-62.248535], [10.53102,-62.819824], [9.925566,-62.358398], 
    [10.033767,-62.226562], [9.838979,-61.611328], [9.449062,-60.820312], 
    [9.18887,-60.776367], [8.581021,-60.600586], [8.581021,-60.073242], 
    [8.320212,-59.853516], [7.798079,-60.46875], [7.493196,-60.688477], 
    [7.144499,-60.512695], [7.144499,-60.292969], [6.926427,-60.292969], 
    [6.664608,-61.12793], [6.489983,-61.12793], [6.271618,-61.12793],
    [5.922045,-61.347656], [5.178482,-60.688477]
]

class Prediccion {
    final int golesLocal;
    final int golesVisitante;
    final String? equipoClasificado;
    String? ganadorPenalesUsuario;

    Prediccion({
        required this.golesLocal,
        required this.golesVisitante,
        this.equipoClasificado,
    });

    bool get esEmpate => golesLocal == golesVisitante;

    bool get ganaLocal => golesLocal > golesVisitante;

    bool get ganaVisitante => golesVisitante > golesLocal;
}
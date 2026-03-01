enum RondaEliminatoria {
    dieciseisavos,
    octavos,
    cuartos,
    semifinal,
    tercerLugar,
    finalRonda
}

enum TipoEliminatoria {
    ninguna,
    idaVuelta,
    partidoUnico,
}
    
class Partido {
    final String equipoLocal;
    final String equipoVisitante;
    //final DateTime fecha;
    final int golesLocal;
    final int golesVisitante;
    final String fase;
    final RondaEliminatoria? ronda;
    final String? serieId;
    final bool esVuelta;
    final String? equipoClasificadoReal;
    final TipoEliminatoria tipoEliminatoria;
    final bool fueAPenales;
    final String? ganadorPenalesReal;

    Partido({
        required this.equipoLocal,
        required this.equipoVisitante,

        required this.golesLocal,
        required this.golesVisitante,
        required this.fase,

        this.ronda,
        this.serieId,
        this.esVuelta = false,
        this.equipoClasificadoReal,

        this.tipoEliminatoria = TipoEliminatoria.ninguna,
        this.fueAPenales = false,
        this.ganadorPenalesReal,
    });

    bool get esEmpate => golesLocal == golesVisitante;

    bool get ganaLocal => golesLocal > golesVisitante;

    bool get ganaVisitante => golesVisitante > golesLocal;
}
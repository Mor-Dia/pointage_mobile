{{-- 
  Exemple de code pour afficher les statuts dans la page Planification
  Fichier : resources/views/planifications/index.blade.php (ou équivalent)
--}}

{{-- Dans le tableau des planifications --}}
<table class="table">
    <thead>
        <tr>
            <th>DATE DEBUT</th>
            <th>DATE FIN</th>
            <th>ASSIGNÉ À</th>
            <th>PROJET</th>
            <th>STATUS</th>
            <th>ACTIONS</th>
        </tr>
    </thead>
    <tbody>
        @foreach($planifications as $planification)
        <tr>
            <td>{{ \Carbon\Carbon::parse($planification->date_debut)->format('d/m/Y') }}</td>
            <td>{{ \Carbon\Carbon::parse($planification->date_fin)->format('d/m/Y') }}</td>
            <td>{{ $planification->personnel->prenom ?? '' }} {{ $planification->personnel->nom ?? '' }}</td>
            <td>
                <span class="badge bg-dark">{{ $planification->nombre_projet ?? '01' }}</span>
            </td>
            <td>
                {{-- Vérifier le statut des fonctionnalités de cette planification --}}
                @php
                    $toutesClosturees = true;
                    $auMoinsUneEnCours = false;
                    
                    foreach($planification->details as $detail) {
                        if($detail->fonctionnalite) {
                            if($detail->fonctionnalite->statut === 'en_cours') {
                                $auMoinsUneEnCours = true;
                                $toutesClosturees = false;
                                break;
                            }
                        }
                    }
                @endphp
                
                @if($toutesClosturees && !$auMoinsUneEnCours)
                    <span class="badge-cloturee">Clôturée</span>
                @else
                    <span class="badge-en-cours">En cours</span>
                @endif
            </td>
            <td>
                <div class="dropdown">
                    <button class="btn btn-sm" type="button" data-bs-toggle="dropdown">
                        ⚙️
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="/planifications/{{ $planification->id }}">Voir détails</a></li>
                        <li><a class="dropdown-item" href="/planifications/{{ $planification->id }}/edit">Modifier</a></li>
                        @if($toutesClosturees)
                        <li><a class="dropdown-item text-muted" href="#" disabled>Réouvrir</a></li>
                        @endif
                    </ul>
                </div>
            </td>
        </tr>
        @endforeach
    </tbody>
</table>

{{-- Styles CSS à ajouter --}}
<style>
.badge-en-cours {
    background-color: #10b981;
    color: white;
    padding: 6px 14px;
    border-radius: 6px;
    font-size: 12px;
    font-weight: 600;
    display: inline-block;
}

.badge-cloturee {
    background-color: #6b7280;
    color: white;
    padding: 6px 14px;
    border-radius: 6px;
    font-size: 12px;
    font-weight: 600;
    display: inline-block;
}

.badge-en-cours::before {
    content: '●';
    margin-right: 6px;
    color: white;
}

.badge-cloturee::before {
    content: '✓';
    margin-right: 6px;
    color: white;
}
</style>

{{-- Alternative : Page dédiée aux planifications clôturées --}}
{{-- Créer un nouveau fichier : resources/views/planifications/cloturees.blade.php --}}

@extends('layouts.app')

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3>
                        <i class="fas fa-check-circle text-success"></i>
                        Fonctionnalités Clôturées
                    </h3>
                    <a href="/planifications" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Retour
                    </a>
                </div>
                
                <div class="card-body">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>PROJET</th>
                                <th>EPIC</th>
                                <th>FONCTIONNALITÉ</th>
                                <th>TÂCHES</th>
                                <th>DURÉE TOTALE</th>
                                <th>ASSIGNÉ À</th>
                                <th>DATE CLÔTURE</th>
                                <th>ACTIONS</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($fonctionnalites as $fonc)
                            <tr>
                                <td>{{ $fonc->epic->projet->nom ?? 'N/A' }}</td>
                                <td>{{ $fonc->epic->nom ?? 'N/A' }}</td>
                                <td>
                                    <strong>{{ $fonc->nom }}</strong>
                                    <br>
                                    <small class="text-muted">{{ $fonc->description ?? '' }}</small>
                                </td>
                                <td>
                                    <span class="badge bg-info">
                                        {{ $fonc->taches->count() }} tâches
                                    </span>
                                </td>
                                <td>
                                    @php
                                        $dureeTotal = 0;
                                        foreach($fonc->taches as $tache) {
                                            if($tache->duree) {
                                                list($h, $m, $s) = explode(':', $tache->duree);
                                                $dureeTotal += ($h * 3600) + ($m * 60) + $s;
                                            }
                                        }
                                        $heures = floor($dureeTotal / 3600);
                                        $minutes = floor(($dureeTotal % 3600) / 60);
                                    @endphp
                                    <span class="badge bg-primary">
                                        {{ $heures }}h {{ $minutes }}min
                                    </span>
                                </td>
                                <td>
                                    {{-- Récupérer depuis la planification --}}
                                    {{ $fonc->planification->personnel->prenom ?? '' }} 
                                    {{ $fonc->planification->personnel->nom ?? '' }}
                                </td>
                                <td>{{ \Carbon\Carbon::parse($fonc->updated_at)->format('d/m/Y H:i') }}</td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary" 
                                            onclick="voirDetails({{ $fonc->id }})">
                                        <i class="fas fa-eye"></i> Détails
                                    </button>
                                </td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                    
                    {{-- Pagination --}}
                    <div class="d-flex justify-content-center">
                        {{ $fonctionnalites->links() }}
                    </div>
                    
                    {{-- Si aucune fonctionnalité clôturée --}}
                    @if($fonctionnalites->isEmpty())
                    <div class="text-center py-5">
                        <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                        <p class="text-muted">Aucune fonctionnalité clôturée pour le moment</p>
                    </div>
                    @endif
                </div>
            </div>
        </div>
    </div>
</div>

{{-- Modal pour voir les détails --}}
<div class="modal fade" id="detailsModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Détails de la fonctionnalité</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body" id="modalContent">
                <!-- Contenu chargé dynamiquement -->
            </div>
        </div>
    </div>
</div>

<script>
function voirDetails(fonctionnaliteId) {
    // Charger les détails via AJAX
    fetch(`/api/fonctionnalites/${fonctionnaliteId}/details`)
        .then(response => response.json())
        .then(data => {
            let html = '<h6>Tâches terminées :</h6><ul>';
            data.taches.forEach(tache => {
                html += `<li>
                    <strong>${tache.nom}</strong> 
                    <span class="badge bg-success ms-2">✓ Terminée</span>
                    ${tache.duree ? `<span class="text-muted ms-2">(${tache.duree})</span>` : ''}
                </li>`;
            });
            html += '</ul>';
            
            document.getElementById('modalContent').innerHTML = html;
            new bootstrap.Modal(document.getElementById('detailsModal')).show();
        });
}
</script>

@endsection

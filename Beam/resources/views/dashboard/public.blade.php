@extends('layouts.simple')

@section('title', 'Public dashboard')

@section('content')

    <div id="dashboard">
        <dashboard-root :articles-url="articlesUrl" :time-histogram-url="timeHistogramUrl">
        </dashboard-root>
    </div>

    <script type="text/javascript">
        new Vue({
            el: "#dashboard",
            components: {
                DashboardRoot
            },
            store: DashboardStore,
            data: function() {
                return {
                    articlesUrl: "{!! route('public.articles.json') !!}",
                    timeHistogramUrl: "{!! route('public.timeHistogram.json') !!}"
                }
            }
        })
    </script>

@endsection

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8 (Debian 15.8-1.pgdg120+1)
-- Dumped by pg_dump version 15.8 (Ubuntu 15.8-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: b; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA b;


ALTER SCHEMA b OWNER TO postgres;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: release; Type: TABLE; Schema: b; Owner: postgres
--

CREATE TABLE b.release (
    id bigint NOT NULL,
    title character varying(250) NOT NULL,
    date date NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    hash integer,
    q numeric(7,5)
);


ALTER TABLE b.release OWNER TO postgres;

--
-- Name: b.release_details_id_seq; Type: SEQUENCE; Schema: b; Owner: postgres
--

CREATE SEQUENCE b."b.release_details_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE b."b.release_details_id_seq" OWNER TO postgres;

--
-- Name: b.release_details_id_seq; Type: SEQUENCE OWNED BY; Schema: b; Owner: postgres
--

ALTER SEQUENCE b."b.release_details_id_seq" OWNED BY b.release.id;


--
-- Name: django_migrations; Type: TABLE; Schema: b; Owner: postgres
--

CREATE TABLE b.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE b.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: b; Owner: postgres
--

CREATE SEQUENCE b.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE b.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: b; Owner: postgres
--

ALTER SEQUENCE b.django_migrations_id_seq OWNED BY b.django_migrations.id;


--
-- Name: player_rating; Type: TABLE; Schema: b; Owner: postgres
--

CREATE TABLE b.player_rating (
    id bigint NOT NULL,
    player_id integer NOT NULL,
    rating integer NOT NULL,
    rating_change integer,
    release_id bigint NOT NULL,
    place numeric(7,1),
    place_change numeric(7,1)
);


ALTER TABLE b.player_rating OWNER TO postgres;

--
-- Name: player_ranking; Type: MATERIALIZED VIEW; Schema: b; Owner: postgres
--

CREATE MATERIALIZED VIEW b.player_ranking AS
 SELECT rank() OVER (PARTITION BY player_rating.release_id ORDER BY player_rating.rating DESC) AS place,
    player_rating.player_id,
    player_rating.rating,
    player_rating.rating_change,
    player_rating.release_id
   FROM b.player_rating
  WITH NO DATA;


ALTER TABLE b.player_ranking OWNER TO postgres;

--
-- Name: player_rating_by_tournament_id_seq_new; Type: SEQUENCE; Schema: b; Owner: postgres
--

CREATE SEQUENCE b.player_rating_by_tournament_id_seq_new
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE b.player_rating_by_tournament_id_seq_new OWNER TO postgres;

--
-- Name: player_rating_by_tournament; Type: TABLE; Schema: b; Owner: postgres
--

CREATE TABLE b.player_rating_by_tournament (
    id bigint DEFAULT nextval('b.player_rating_by_tournament_id_seq_new'::regclass) NOT NULL,
    player_id integer NOT NULL,
    weeks_since_tournament smallint NOT NULL,
    cur_score integer NOT NULL,
    release_id bigint NOT NULL,
    tournament_result_id bigint,
    initial_score integer,
    tournament_id integer
);


ALTER TABLE b.player_rating_by_tournament OWNER TO postgres;

--
-- Name: player_rating_id_seq; Type: SEQUENCE; Schema: b; Owner: postgres
--

CREATE SEQUENCE b.player_rating_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE b.player_rating_id_seq OWNER TO postgres;

--
-- Name: player_rating_id_seq1; Type: SEQUENCE; Schema: b; Owner: postgres
--

CREATE SEQUENCE b.player_rating_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE b.player_rating_id_seq1 OWNER TO postgres;

--
-- Name: player_rating_id_seq1; Type: SEQUENCE OWNED BY; Schema: b; Owner: postgres
--

ALTER SEQUENCE b.player_rating_id_seq1 OWNED BY b.player_rating.id;


--
-- Name: team_rating; Type: TABLE; Schema: b; Owner: postgres
--

CREATE TABLE b.team_rating (
    id bigint NOT NULL,
    team_id integer NOT NULL,
    rating integer NOT NULL,
    trb integer NOT NULL,
    rating_change integer,
    release_id bigint NOT NULL,
    place numeric(7,1),
    place_change numeric(7,1),
    rating_for_next_release integer
);


ALTER TABLE b.team_rating OWNER TO postgres;

--
-- Name: releases_id_seq; Type: SEQUENCE; Schema: b; Owner: postgres
--

CREATE SEQUENCE b.releases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE b.releases_id_seq OWNER TO postgres;

--
-- Name: releases_id_seq; Type: SEQUENCE OWNED BY; Schema: b; Owner: postgres
--

ALTER SEQUENCE b.releases_id_seq OWNED BY b.team_rating.id;


--
-- Name: team_lost_heredity; Type: TABLE; Schema: b; Owner: postgres
--

CREATE TABLE b.team_lost_heredity (
    id bigint NOT NULL,
    season_id integer NOT NULL,
    team_id integer NOT NULL,
    date date NOT NULL
);


ALTER TABLE b.team_lost_heredity OWNER TO postgres;

--
-- Name: team_lost_heredity_id_seq; Type: SEQUENCE; Schema: b; Owner: postgres
--

CREATE SEQUENCE b.team_lost_heredity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE b.team_lost_heredity_id_seq OWNER TO postgres;

--
-- Name: team_lost_heredity_id_seq; Type: SEQUENCE OWNED BY; Schema: b; Owner: postgres
--

ALTER SEQUENCE b.team_lost_heredity_id_seq OWNED BY b.team_lost_heredity.id;


--
-- Name: team_ranking; Type: MATERIALIZED VIEW; Schema: b; Owner: postgres
--

CREATE MATERIALIZED VIEW b.team_ranking AS
 SELECT rank() OVER (PARTITION BY team_rating.release_id ORDER BY team_rating.rating DESC) AS place,
    team_rating.team_id,
    team_rating.rating,
    team_rating.rating_change,
    team_rating.release_id,
    team_rating.trb
   FROM b.team_rating
  WITH NO DATA;


ALTER TABLE b.team_ranking OWNER TO postgres;

--
-- Name: team_rating_by_player; Type: TABLE; Schema: b; Owner: postgres
--

CREATE TABLE b.team_rating_by_player (
    id bigint NOT NULL,
    player_id integer NOT NULL,
    "order" smallint NOT NULL,
    contribution integer NOT NULL,
    team_rating_id bigint NOT NULL
);


ALTER TABLE b.team_rating_by_player OWNER TO postgres;

--
-- Name: team_rating_by_player_id_seq; Type: SEQUENCE; Schema: b; Owner: postgres
--

CREATE SEQUENCE b.team_rating_by_player_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE b.team_rating_by_player_id_seq OWNER TO postgres;

--
-- Name: team_rating_by_player_id_seq; Type: SEQUENCE OWNED BY; Schema: b; Owner: postgres
--

ALTER SEQUENCE b.team_rating_by_player_id_seq OWNED BY b.team_rating_by_player.id;


--
-- Name: tournament_in_release; Type: TABLE; Schema: b; Owner: postgres
--

CREATE TABLE b.tournament_in_release (
    id bigint NOT NULL,
    tournament_id integer NOT NULL,
    release_id bigint NOT NULL
);


ALTER TABLE b.tournament_in_release OWNER TO postgres;

--
-- Name: tournament_in_release_id_seq; Type: SEQUENCE; Schema: b; Owner: postgres
--

CREATE SEQUENCE b.tournament_in_release_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE b.tournament_in_release_id_seq OWNER TO postgres;

--
-- Name: tournament_in_release_id_seq; Type: SEQUENCE OWNED BY; Schema: b; Owner: postgres
--

ALTER SEQUENCE b.tournament_in_release_id_seq OWNED BY b.tournament_in_release.id;


--
-- Name: tournament_results_id_seq_new; Type: SEQUENCE; Schema: b; Owner: postgres
--

CREATE SEQUENCE b.tournament_results_id_seq_new
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE b.tournament_results_id_seq_new OWNER TO postgres;

--
-- Name: tournament_result; Type: TABLE; Schema: b; Owner: postgres
--

CREATE TABLE b.tournament_result (
    id bigint DEFAULT nextval('b.tournament_results_id_seq_new'::regclass) NOT NULL,
    team_id integer NOT NULL,
    tournament_id integer NOT NULL,
    mp numeric(6,1) NOT NULL,
    bp integer NOT NULL,
    m numeric(6,1) NOT NULL,
    rating integer NOT NULL,
    d1 integer NOT NULL,
    d2 integer NOT NULL,
    rating_change integer NOT NULL,
    is_in_maii_rating boolean NOT NULL,
    r integer NOT NULL,
    rb integer NOT NULL,
    rg integer NOT NULL,
    rt integer NOT NULL
);


ALTER TABLE b.tournament_result OWNER TO postgres;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO postgres;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO postgres;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: base_rosters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.base_rosters (
    id integer NOT NULL,
    player_id integer,
    team_id integer,
    season_id integer,
    start_date date,
    end_date date,
    updated_at timestamp without time zone
);


ALTER TABLE public.base_rosters OWNER TO postgres;

--
-- Name: base_rosters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.base_rosters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.base_rosters_id_seq OWNER TO postgres;

--
-- Name: base_rosters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.base_rosters_id_seq OWNED BY public.base_rosters.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: models; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.models (
    id bigint NOT NULL,
    name text,
    changes_teams boolean,
    changes_rosters boolean,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.models OWNER TO postgres;

--
-- Name: models_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.models_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.models_id_seq OWNER TO postgres;

--
-- Name: models_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.models_id_seq OWNED BY public.models.id;


--
-- Name: ndcg; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ndcg (
    rating_name text,
    tournament_id integer,
    ndcg real,
    updated_at timestamp without time zone
);


ALTER TABLE public.ndcg OWNER TO postgres;

--
-- Name: players; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players (
    id integer,
    first_name text,
    patronymic text,
    last_name text,
    updated_at timestamp without time zone
);


ALTER TABLE public.players OWNER TO postgres;

--
-- Name: rating_individual_old; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rating_individual_old (
    player_id integer,
    rating integer
);


ALTER TABLE public.rating_individual_old OWNER TO postgres;

--
-- Name: rating_individual_old_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rating_individual_old_details (
    player_id integer,
    tournament_id integer,
    rating_now integer,
    rating_original integer
);


ALTER TABLE public.rating_individual_old_details OWNER TO postgres;

--
-- Name: rosters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rosters (
    id bigint NOT NULL,
    tournament_id integer,
    team_id integer,
    player_id integer,
    flag text,
    is_captain boolean
);


ALTER TABLE public.rosters OWNER TO postgres;

--
-- Name: rosters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rosters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rosters_id_seq OWNER TO postgres;

--
-- Name: rosters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rosters_id_seq OWNED BY public.rosters.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: seasons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seasons (
    id integer,
    start date,
    "end" date,
    updated_at timestamp without time zone
);


ALTER TABLE public.seasons OWNER TO postgres;

--
-- Name: teams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teams (
    id integer,
    title text,
    town_id integer,
    updated_at timestamp without time zone
);


ALTER TABLE public.teams OWNER TO postgres;

--
-- Name: tournament_results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tournament_results (
    id bigint NOT NULL,
    tournament_id integer,
    team_id integer,
    team_title text,
    total integer,
    "position" double precision,
    old_rating integer,
    old_rating_delta integer,
    updated_at timestamp without time zone,
    team_city_id integer,
    points integer,
    points_mask text
);


ALTER TABLE public.tournament_results OWNER TO postgres;

--
-- Name: tournament_results_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tournament_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tournament_results_id_seq OWNER TO postgres;

--
-- Name: tournament_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tournament_results_id_seq OWNED BY public.tournament_results.id;


--
-- Name: tournament_rosters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tournament_rosters (
    id integer NOT NULL,
    tournament_id integer,
    team_id integer,
    player_id integer,
    flag text,
    is_captain boolean,
    updated_at timestamp without time zone
);


ALTER TABLE public.tournament_rosters OWNER TO postgres;

--
-- Name: tournament_rosters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tournament_rosters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tournament_rosters_id_seq OWNER TO postgres;

--
-- Name: tournament_rosters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tournament_rosters_id_seq OWNED BY public.tournament_rosters.id;


--
-- Name: tournaments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tournaments (
    id integer,
    title text,
    start_datetime timestamp without time zone,
    end_datetime timestamp without time zone,
    last_edited_at timestamp without time zone,
    questions_count integer,
    typeoft_id integer,
    type text,
    maii_rating boolean,
    maii_rating_updated_at timestamp without time zone,
    maii_aegis boolean,
    maii_aegis_updated_at timestamp without time zone,
    in_old_rating boolean,
    updated_at timestamp without time zone
);


ALTER TABLE public.tournaments OWNER TO postgres;

--
-- Name: towns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.towns (
    id integer,
    title text,
    updated_at timestamp without time zone
);


ALTER TABLE public.towns OWNER TO postgres;

--
-- Name: true_dls; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.true_dls (
    id bigint NOT NULL,
    tournament_id integer,
    true_dl double precision,
    model_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.true_dls OWNER TO postgres;

--
-- Name: true_dls_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.true_dls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.true_dls_id_seq OWNER TO postgres;

--
-- Name: true_dls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.true_dls_id_seq OWNED BY public.true_dls.id;


--
-- Name: wrong_team_ids; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wrong_team_ids (
    id bigint NOT NULL,
    tournament_id integer,
    old_team_id integer,
    new_team_id integer,
    updated_at timestamp(6) without time zone
);


ALTER TABLE public.wrong_team_ids OWNER TO postgres;

--
-- Name: wrong_team_ids_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wrong_team_ids_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wrong_team_ids_id_seq OWNER TO postgres;

--
-- Name: wrong_team_ids_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wrong_team_ids_id_seq OWNED BY public.wrong_team_ids.id;


--
-- Name: django_migrations id; Type: DEFAULT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.django_migrations ALTER COLUMN id SET DEFAULT nextval('b.django_migrations_id_seq'::regclass);


--
-- Name: player_rating id; Type: DEFAULT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.player_rating ALTER COLUMN id SET DEFAULT nextval('b.player_rating_id_seq1'::regclass);


--
-- Name: release id; Type: DEFAULT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.release ALTER COLUMN id SET DEFAULT nextval('b."b.release_details_id_seq"'::regclass);


--
-- Name: team_lost_heredity id; Type: DEFAULT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.team_lost_heredity ALTER COLUMN id SET DEFAULT nextval('b.team_lost_heredity_id_seq'::regclass);


--
-- Name: team_rating id; Type: DEFAULT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.team_rating ALTER COLUMN id SET DEFAULT nextval('b.releases_id_seq'::regclass);


--
-- Name: team_rating_by_player id; Type: DEFAULT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.team_rating_by_player ALTER COLUMN id SET DEFAULT nextval('b.team_rating_by_player_id_seq'::regclass);


--
-- Name: tournament_in_release id; Type: DEFAULT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.tournament_in_release ALTER COLUMN id SET DEFAULT nextval('b.tournament_in_release_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: base_rosters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.base_rosters ALTER COLUMN id SET DEFAULT nextval('public.base_rosters_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: models id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.models ALTER COLUMN id SET DEFAULT nextval('public.models_id_seq'::regclass);


--
-- Name: rosters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rosters ALTER COLUMN id SET DEFAULT nextval('public.rosters_id_seq'::regclass);


--
-- Name: tournament_results id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tournament_results ALTER COLUMN id SET DEFAULT nextval('public.tournament_results_id_seq'::regclass);


--
-- Name: tournament_rosters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tournament_rosters ALTER COLUMN id SET DEFAULT nextval('public.tournament_rosters_id_seq'::regclass);


--
-- Name: true_dls id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.true_dls ALTER COLUMN id SET DEFAULT nextval('public.true_dls_id_seq'::regclass);


--
-- Name: wrong_team_ids id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wrong_team_ids ALTER COLUMN id SET DEFAULT nextval('public.wrong_team_ids_id_seq'::regclass);


--
-- Name: release b.release_details_pkey; Type: CONSTRAINT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.release
    ADD CONSTRAINT "b.release_details_pkey" PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: player_rating_by_tournament player_rating_by_tournament_new_pk; Type: CONSTRAINT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.player_rating_by_tournament
    ADD CONSTRAINT player_rating_by_tournament_new_pk UNIQUE (release_id, player_id, tournament_id);


--
-- Name: player_rating_by_tournament player_rating_by_tournament_new_pkey; Type: CONSTRAINT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.player_rating_by_tournament
    ADD CONSTRAINT player_rating_by_tournament_new_pkey PRIMARY KEY (id);


--
-- Name: player_rating player_rating_pkey; Type: CONSTRAINT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.player_rating
    ADD CONSTRAINT player_rating_pkey PRIMARY KEY (id);


--
-- Name: player_rating player_rating_release_id_player_id_179cda25_uniq; Type: CONSTRAINT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.player_rating
    ADD CONSTRAINT player_rating_release_id_player_id_179cda25_uniq UNIQUE (release_id, player_id);


--
-- Name: release release_date_5a2512d7_uniq; Type: CONSTRAINT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.release
    ADD CONSTRAINT release_date_5a2512d7_uniq UNIQUE (date);


--
-- Name: team_rating releases_pkey; Type: CONSTRAINT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.team_rating
    ADD CONSTRAINT releases_pkey PRIMARY KEY (id);


--
-- Name: team_lost_heredity team_lost_heredity_pkey; Type: CONSTRAINT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.team_lost_heredity
    ADD CONSTRAINT team_lost_heredity_pkey PRIMARY KEY (id);


--
-- Name: team_lost_heredity team_lost_heredity_season_id_team_id_c3e8a97e_uniq; Type: CONSTRAINT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.team_lost_heredity
    ADD CONSTRAINT team_lost_heredity_season_id_team_id_c3e8a97e_uniq UNIQUE (season_id, team_id);


--
-- Name: team_rating_by_player team_rating_by_player_pkey; Type: CONSTRAINT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.team_rating_by_player
    ADD CONSTRAINT team_rating_by_player_pkey PRIMARY KEY (id);


--
-- Name: team_rating_by_player team_rating_by_player_team_rating_id_player_id_4f054658_uniq; Type: CONSTRAINT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.team_rating_by_player
    ADD CONSTRAINT team_rating_by_player_team_rating_id_player_id_4f054658_uniq UNIQUE (team_rating_id, player_id);


--
-- Name: team_rating team_rating_release_id_team_id_3d8be5ad_uniq; Type: CONSTRAINT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.team_rating
    ADD CONSTRAINT team_rating_release_id_team_id_3d8be5ad_uniq UNIQUE (release_id, team_id);


--
-- Name: tournament_in_release tournament_in_release_pkey; Type: CONSTRAINT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.tournament_in_release
    ADD CONSTRAINT tournament_in_release_pkey PRIMARY KEY (id);


--
-- Name: tournament_in_release tournament_in_release_release_id_tournament_id_1da45065_uniq; Type: CONSTRAINT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.tournament_in_release
    ADD CONSTRAINT tournament_in_release_release_id_tournament_id_1da45065_uniq UNIQUE (release_id, tournament_id);


--
-- Name: tournament_result tournament_results_new_pkey; Type: CONSTRAINT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.tournament_result
    ADD CONSTRAINT tournament_results_new_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: models models_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.models
    ADD CONSTRAINT models_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: true_dls true_dls_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.true_dls
    ADD CONSTRAINT true_dls_pkey PRIMARY KEY (id);


--
-- Name: wrong_team_ids wrong_team_ids_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wrong_team_ids
    ADD CONSTRAINT wrong_team_ids_pkey PRIMARY KEY (id);


--
-- Name: player_ranking_place_idx; Type: INDEX; Schema: b; Owner: postgres
--

CREATE INDEX player_ranking_place_idx ON b.player_ranking USING btree (place);


--
-- Name: player_ranking_player_id_idx; Type: INDEX; Schema: b; Owner: postgres
--

CREATE INDEX player_ranking_player_id_idx ON b.player_ranking USING btree (player_id);


--
-- Name: player_ranking_release_id_idx; Type: INDEX; Schema: b; Owner: postgres
--

CREATE INDEX player_ranking_release_id_idx ON b.player_ranking USING btree (release_id);


--
-- Name: player_rating_by_tournament_player_id_index; Type: INDEX; Schema: b; Owner: postgres
--

CREATE INDEX player_rating_by_tournament_player_id_index ON b.player_rating_by_tournament USING btree (player_id);


--
-- Name: player_rating_release_id_index; Type: INDEX; Schema: b; Owner: postgres
--

CREATE INDEX player_rating_release_id_index ON b.player_rating USING btree (release_id);


--
-- Name: player_rating_release_id_rating_index; Type: INDEX; Schema: b; Owner: postgres
--

CREATE INDEX player_rating_release_id_rating_index ON b.player_rating USING btree (release_id, rating DESC);


--
-- Name: releases_release_id_72319d1e; Type: INDEX; Schema: b; Owner: postgres
--

CREATE INDEX releases_release_id_72319d1e ON b.team_rating USING btree (release_id);


--
-- Name: team_ranking_place_idx; Type: INDEX; Schema: b; Owner: postgres
--

CREATE INDEX team_ranking_place_idx ON b.team_ranking USING btree (place);


--
-- Name: team_ranking_release_id_idx; Type: INDEX; Schema: b; Owner: postgres
--

CREATE INDEX team_ranking_release_id_idx ON b.team_ranking USING btree (release_id);


--
-- Name: team_ranking_team_id_idx; Type: INDEX; Schema: b; Owner: postgres
--

CREATE INDEX team_ranking_team_id_idx ON b.team_ranking USING btree (team_id);


--
-- Name: team_rating_by_player_team_rating_id_7b018454; Type: INDEX; Schema: b; Owner: postgres
--

CREATE INDEX team_rating_by_player_team_rating_id_7b018454 ON b.team_rating_by_player USING btree (team_rating_id);


--
-- Name: team_rating_by_player_team_rating_id_player_id_08ec8a7b_idx; Type: INDEX; Schema: b; Owner: postgres
--

CREATE INDEX team_rating_by_player_team_rating_id_player_id_08ec8a7b_idx ON b.team_rating_by_player USING btree (team_rating_id, player_id, "order");


--
-- Name: team_rating_release_id_team_id_place_change_4e973e84_idx; Type: INDEX; Schema: b; Owner: postgres
--

CREATE INDEX team_rating_release_id_team_id_place_change_4e973e84_idx ON b.team_rating USING btree (release_id, team_id, place_change);


--
-- Name: team_rating_release_id_team_id_place_fbb7e2cd_idx; Type: INDEX; Schema: b; Owner: postgres
--

CREATE INDEX team_rating_release_id_team_id_place_fbb7e2cd_idx ON b.team_rating USING btree (release_id, team_id, place);


--
-- Name: team_rating_release_id_team_id_rating_8a22c5ff_idx; Type: INDEX; Schema: b; Owner: postgres
--

CREATE INDEX team_rating_release_id_team_id_rating_8a22c5ff_idx ON b.team_rating USING btree (release_id, team_id, rating);


--
-- Name: team_rating_release_id_team_id_rating_change_38f9f262_idx; Type: INDEX; Schema: b; Owner: postgres
--

CREATE INDEX team_rating_release_id_team_id_rating_change_38f9f262_idx ON b.team_rating USING btree (release_id, team_id, rating_change);


--
-- Name: tournament_in_release_release_id_af6ae186; Type: INDEX; Schema: b; Owner: postgres
--

CREATE INDEX tournament_in_release_release_id_af6ae186 ON b.tournament_in_release USING btree (release_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: base_rosters_player_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX base_rosters_player_id_index ON public.base_rosters USING btree (player_id);


--
-- Name: base_rosters_team_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX base_rosters_team_id_index ON public.base_rosters USING btree (team_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: index_models_on_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_models_on_name ON public.models USING btree (name);


--
-- Name: index_true_dls_on_model_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_true_dls_on_model_id ON public.true_dls USING btree (model_id);


--
-- Name: players_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX players_id_index ON public.players USING btree (id);


--
-- Name: tournament_results_team_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tournament_results_team_id_index ON public.tournament_results USING btree (team_id);


--
-- Name: tournament_results_team_id_tournament_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tournament_results_team_id_tournament_id_index ON public.tournament_results USING btree (team_id, tournament_id);


--
-- Name: tournament_results_tournament_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tournament_results_tournament_id_index ON public.tournament_results USING btree (tournament_id);


--
-- Name: tournament_rosters_team_id_tournament_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tournament_rosters_team_id_tournament_id_index ON public.tournament_rosters USING btree (team_id, tournament_id);


--
-- Name: tournament_rosters_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX tournament_rosters_uindex ON public.tournament_rosters USING btree (player_id, tournament_id, team_id);


--
-- Name: tournaments_end_datetime_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tournaments_end_datetime_index ON public.tournaments USING btree (end_datetime DESC);


--
-- Name: tournaments_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tournaments_id_index ON public.tournaments USING btree (id);


--
-- Name: tournaments_roster_player_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tournaments_roster_player_id_index ON public.tournament_rosters USING btree (player_id);


--
-- Name: tournaments_roster_tournament_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tournaments_roster_tournament_id_index ON public.tournament_rosters USING btree (tournament_id);


--
-- Name: tournaments_start_datetime_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tournaments_start_datetime_index ON public.tournaments USING btree (start_datetime DESC);


--
-- Name: tournaments_type_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tournaments_type_index ON public.tournaments USING btree (type);


--
-- Name: player_rating_by_tournament player_rating_by_tournament_new_release_id_fkey; Type: FK CONSTRAINT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.player_rating_by_tournament
    ADD CONSTRAINT player_rating_by_tournament_new_release_id_fkey FOREIGN KEY (release_id) REFERENCES b.release(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: player_rating player_rating_release_id_52b7952e_fk_release_details_id; Type: FK CONSTRAINT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.player_rating
    ADD CONSTRAINT player_rating_release_id_52b7952e_fk_release_details_id FOREIGN KEY (release_id) REFERENCES b.release(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: team_rating releases_release_id_72319d1e_fk_release_details_id; Type: FK CONSTRAINT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.team_rating
    ADD CONSTRAINT releases_release_id_72319d1e_fk_release_details_id FOREIGN KEY (release_id) REFERENCES b.release(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: team_rating_by_player team_rating_by_player_team_rating_id_7b018454_fk_releases_id; Type: FK CONSTRAINT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.team_rating_by_player
    ADD CONSTRAINT team_rating_by_player_team_rating_id_7b018454_fk_releases_id FOREIGN KEY (team_rating_id) REFERENCES b.team_rating(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tournament_in_release tournament_in_release_release_id_af6ae186_fk_release_id; Type: FK CONSTRAINT; Schema: b; Owner: postgres
--

ALTER TABLE ONLY b.tournament_in_release
    ADD CONSTRAINT tournament_in_release_release_id_af6ae186_fk_release_id FOREIGN KEY (release_id) REFERENCES b.release(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: true_dls fk_rails_8bcd904df1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.true_dls
    ADD CONSTRAINT fk_rails_8bcd904df1 FOREIGN KEY (model_id) REFERENCES public.models(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--


--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: articles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE articles (
    id integer NOT NULL,
    title character varying(255),
    body text,
    author_id integer
);


--
-- Name: articles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE articles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE articles_id_seq OWNED BY articles.id;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE companies (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    num_employees integer,
    total_money_raised character varying(255),
    twitter_username character varying(255),
    category_code character varying(255),
    city character varying(255),
    twitter_followers integer,
    career_page_link character varying(255),
    year_founded integer,
    overview text
);


--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE companies_id_seq OWNED BY companies.id;


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE jobs (
    id integer NOT NULL,
    link character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    title character varying(255),
    full_text text,
    is_draft boolean,
    company_id integer,
    dept character varying(255),
    years_exp integer,
    sub_dept character varying(255),
    description text,
    key_phrases character varying(255)[] DEFAULT '{}'::character varying[],
    req_skills character varying(255)[] DEFAULT '{}'::character varying[]
);


--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE jobs_id_seq OWNED BY jobs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: search_suggestions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE search_suggestions (
    id integer NOT NULL,
    term character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    popularity integer
);


--
-- Name: search_suggestions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE search_suggestions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: search_suggestions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE search_suggestions_id_seq OWNED BY search_suggestions.id;


--
-- Name: taxonomies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE taxonomies (
    id integer NOT NULL,
    title character varying(255),
    level character varying(255),
    base_title character varying(255),
    dept character varying(255),
    expert_phrases hstore
);


--
-- Name: taxonomies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taxonomies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taxonomies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taxonomies_id_seq OWNED BY taxonomies.id;


--
-- Name: user_jobs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_jobs (
    id integer NOT NULL,
    user_id integer,
    saved_job_id integer,
    applied_job_id integer
);


--
-- Name: user_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_jobs_id_seq OWNED BY user_jobs.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password_digest character varying(255) NOT NULL,
    session_token character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    job_settings text,
    is_admin boolean,
    guest boolean,
    avatar_file_name character varying(255),
    avatar_content_type character varying(255),
    avatar_file_size integer,
    avatar_updated_at timestamp without time zone,
    fname character varying(255),
    lname character varying(255),
    title character varying(255),
    location character varying(255),
    company_id integer,
    job_filters hstore DEFAULT ''::hstore
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY articles ALTER COLUMN id SET DEFAULT nextval('articles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY companies ALTER COLUMN id SET DEFAULT nextval('companies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY jobs ALTER COLUMN id SET DEFAULT nextval('jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY search_suggestions ALTER COLUMN id SET DEFAULT nextval('search_suggestions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taxonomies ALTER COLUMN id SET DEFAULT nextval('taxonomies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_jobs ALTER COLUMN id SET DEFAULT nextval('user_jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: articles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- Name: companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: search_suggestions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY search_suggestions
    ADD CONSTRAINT search_suggestions_pkey PRIMARY KEY (id);


--
-- Name: taxonomies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY taxonomies
    ADD CONSTRAINT taxonomies_pkey PRIMARY KEY (id);


--
-- Name: user_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_jobs
    ADD CONSTRAINT user_jobs_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20140108130445');

INSERT INTO schema_migrations (version) VALUES ('20140108171145');

INSERT INTO schema_migrations (version) VALUES ('20140108204401');

INSERT INTO schema_migrations (version) VALUES ('20140110193608');

INSERT INTO schema_migrations (version) VALUES ('20140110224103');

INSERT INTO schema_migrations (version) VALUES ('20140113160448');

INSERT INTO schema_migrations (version) VALUES ('20140117171540');

INSERT INTO schema_migrations (version) VALUES ('20140124163000');

INSERT INTO schema_migrations (version) VALUES ('20140124190838');

INSERT INTO schema_migrations (version) VALUES ('20140124191934');

INSERT INTO schema_migrations (version) VALUES ('20140124195659');

INSERT INTO schema_migrations (version) VALUES ('20140127154907');

INSERT INTO schema_migrations (version) VALUES ('20140127185927');

INSERT INTO schema_migrations (version) VALUES ('20140128201459');

INSERT INTO schema_migrations (version) VALUES ('20140128203909');

INSERT INTO schema_migrations (version) VALUES ('20140128204635');

INSERT INTO schema_migrations (version) VALUES ('20140128205202');

INSERT INTO schema_migrations (version) VALUES ('20140130015949');

INSERT INTO schema_migrations (version) VALUES ('20140130165413');

INSERT INTO schema_migrations (version) VALUES ('20140130222732');

INSERT INTO schema_migrations (version) VALUES ('20140130230446');

INSERT INTO schema_migrations (version) VALUES ('20140131170738');

INSERT INTO schema_migrations (version) VALUES ('20140204180902');

INSERT INTO schema_migrations (version) VALUES ('20140204192820');

INSERT INTO schema_migrations (version) VALUES ('20140205074242');

INSERT INTO schema_migrations (version) VALUES ('20140206172137');

INSERT INTO schema_migrations (version) VALUES ('20140207035809');

INSERT INTO schema_migrations (version) VALUES ('20140207231243');

INSERT INTO schema_migrations (version) VALUES ('20140208190531');

INSERT INTO schema_migrations (version) VALUES ('20140209194638');

INSERT INTO schema_migrations (version) VALUES ('20140211180757');

INSERT INTO schema_migrations (version) VALUES ('20140214144328');

INSERT INTO schema_migrations (version) VALUES ('20140214144557');

INSERT INTO schema_migrations (version) VALUES ('20140214175939');

INSERT INTO schema_migrations (version) VALUES ('20140217202639');

INSERT INTO schema_migrations (version) VALUES ('20140217205216');

INSERT INTO schema_migrations (version) VALUES ('20140217205732');

INSERT INTO schema_migrations (version) VALUES ('20140220053030');

INSERT INTO schema_migrations (version) VALUES ('20140220133726');

INSERT INTO schema_migrations (version) VALUES ('20140222173116');

INSERT INTO schema_migrations (version) VALUES ('20140224232946');

INSERT INTO schema_migrations (version) VALUES ('20140228135029');

INSERT INTO schema_migrations (version) VALUES ('20140302185524');

INSERT INTO schema_migrations (version) VALUES ('20140303162346');

INSERT INTO schema_migrations (version) VALUES ('20140303172140');

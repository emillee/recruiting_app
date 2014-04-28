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
    title character varying(255) DEFAULT ''::character varying,
    body text DEFAULT ''::text,
    author_id integer,
    tag_id integer,
    company_id integer,
    investor_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
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
    overview text,
    neighborhood character varying(255),
    career_sections hstore DEFAULT ''::hstore,
    snapshots_file_name character varying(255),
    snapshots_content_type character varying(255),
    snapshots_file_size integer,
    snapshots_updated_at timestamp without time zone,
    logo_file_name character varying(255),
    logo_content_type character varying(255),
    logo_file_size integer,
    logo_updated_at timestamp without time zone
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
-- Name: groups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE groups (
    id integer NOT NULL,
    name character varying(255)
);


--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE groups_id_seq OWNED BY groups.id;


--
-- Name: identities; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE identities (
    id integer NOT NULL,
    uid character varying(255),
    provider character varying(255),
    user_id integer,
    oauth_token character varying(255),
    oauth_expires_at timestamp without time zone,
    oauth_secret character varying(255)
);


--
-- Name: identities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE identities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: identities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE identities_id_seq OWNED BY identities.id;


--
-- Name: investors; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE investors (
    id integer NOT NULL,
    name character varying(255),
    neighborhood character varying(255),
    stage character varying(255)[] DEFAULT '{}'::character varying[],
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    logo_file_name character varying(255),
    logo_content_type character varying(255),
    logo_file_size integer,
    logo_updated_at timestamp without time zone,
    overview text,
    check_size numeric[] DEFAULT '{}'::numeric[],
    snapshots_file_name character varying(255),
    snapshots_content_type character varying(255),
    snapshots_file_size integer,
    snapshots_updated_at timestamp without time zone,
    about text
);


--
-- Name: investors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE investors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: investors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE investors_id_seq OWNED BY investors.id;


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
-- Name: object_skills; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE object_skills (
    id integer NOT NULL,
    user_id integer,
    level integer,
    company_id integer,
    skill_id integer
);


--
-- Name: object_skills_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE object_skills_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: object_skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE object_skills_id_seq OWNED BY object_skills.id;


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
-- Name: skills; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE skills (
    id integer NOT NULL,
    skill_name character varying(255),
    skill_dept character varying(255),
    skill_sub_dept character varying(255),
    required_phrases character varying(255)[] DEFAULT '{}'::character varying[],
    preferred_phrases character varying(255)[] DEFAULT '{}'::character varying[],
    logo_file_name character varying(255),
    logo_content_type character varying(255),
    logo_file_size integer,
    logo_updated_at timestamp without time zone
);


--
-- Name: skills_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE skills_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE skills_id_seq OWNED BY skills.id;


--
-- Name: taggings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE taggings (
    id integer NOT NULL,
    company_id integer,
    tag_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    article_id integer
);


--
-- Name: taggings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taggings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taggings_id_seq OWNED BY taggings.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tags (
    id integer NOT NULL,
    tag_name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


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
-- Name: user_articles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_articles (
    id integer NOT NULL,
    user_id integer,
    article_id integer
);


--
-- Name: user_articles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_articles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_articles_id_seq OWNED BY user_articles.id;


--
-- Name: user_job_preapprovals; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_job_preapprovals (
    id integer NOT NULL,
    user_id integer,
    job_id integer
);


--
-- Name: user_job_preapprovals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_job_preapprovals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_job_preapprovals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_job_preapprovals_id_seq OWNED BY user_job_preapprovals.id;


--
-- Name: user_jobs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_jobs (
    id integer NOT NULL,
    user_id integer,
    saved_job_id integer,
    applied_job_id integer,
    removed_job_id integer
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
    job_filters hstore DEFAULT ''::hstore,
    biography text,
    intro text,
    interested_in_meeting text,
    company_settings text,
    investor_company_id integer,
    snapshots_file_name character varying(255),
    snapshots_content_type character varying(255),
    snapshots_file_size integer,
    snapshots_updated_at timestamp without time zone,
    job_prefs text,
    location_from character varying(255)
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

ALTER TABLE ONLY groups ALTER COLUMN id SET DEFAULT nextval('groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY identities ALTER COLUMN id SET DEFAULT nextval('identities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY investors ALTER COLUMN id SET DEFAULT nextval('investors_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY jobs ALTER COLUMN id SET DEFAULT nextval('jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY object_skills ALTER COLUMN id SET DEFAULT nextval('object_skills_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY search_suggestions ALTER COLUMN id SET DEFAULT nextval('search_suggestions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY skills ALTER COLUMN id SET DEFAULT nextval('skills_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taggings ALTER COLUMN id SET DEFAULT nextval('taggings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taxonomies ALTER COLUMN id SET DEFAULT nextval('taxonomies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_articles ALTER COLUMN id SET DEFAULT nextval('user_articles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_job_preapprovals ALTER COLUMN id SET DEFAULT nextval('user_job_preapprovals_id_seq'::regclass);


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
-- Name: groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: identities_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: investors_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY investors
    ADD CONSTRAINT investors_pkey PRIMARY KEY (id);


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
-- Name: skills_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY skills
    ADD CONSTRAINT skills_pkey PRIMARY KEY (id);


--
-- Name: taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: taxonomies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY taxonomies
    ADD CONSTRAINT taxonomies_pkey PRIMARY KEY (id);


--
-- Name: user_articles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_articles
    ADD CONSTRAINT user_articles_pkey PRIMARY KEY (id);


--
-- Name: user_job_preapprovals_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_job_preapprovals
    ADD CONSTRAINT user_job_preapprovals_pkey PRIMARY KEY (id);


--
-- Name: user_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_jobs
    ADD CONSTRAINT user_jobs_pkey PRIMARY KEY (id);


--
-- Name: user_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY object_skills
    ADD CONSTRAINT user_skills_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_jobs_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_jobs_on_company_id ON jobs USING btree (company_id);


--
-- Name: index_object_skills_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_object_skills_on_company_id ON object_skills USING btree (company_id);


--
-- Name: index_object_skills_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_object_skills_on_user_id ON object_skills USING btree (user_id);


--
-- Name: index_user_jobs_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_jobs_on_user_id ON user_jobs USING btree (user_id);


--
-- Name: index_user_jobs_on_user_id_and_applied_job_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_jobs_on_user_id_and_applied_job_id ON user_jobs USING btree (user_id, applied_job_id);


--
-- Name: index_user_jobs_on_user_id_and_removed_job_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_jobs_on_user_id_and_removed_job_id ON user_jobs USING btree (user_id, removed_job_id);


--
-- Name: index_user_jobs_on_user_id_and_saved_job_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_jobs_on_user_id_and_saved_job_id ON user_jobs USING btree (user_id, saved_job_id);


--
-- Name: index_users_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_company_id ON users USING btree (company_id);


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

INSERT INTO schema_migrations (version) VALUES ('20140304170409');

INSERT INTO schema_migrations (version) VALUES ('20140304170745');

INSERT INTO schema_migrations (version) VALUES ('20140304170953');

INSERT INTO schema_migrations (version) VALUES ('20140305141438');

INSERT INTO schema_migrations (version) VALUES ('20140307054918');

INSERT INTO schema_migrations (version) VALUES ('20140307154315');

INSERT INTO schema_migrations (version) VALUES ('20140307154916');

INSERT INTO schema_migrations (version) VALUES ('20140307170350');

INSERT INTO schema_migrations (version) VALUES ('20140307171833');

INSERT INTO schema_migrations (version) VALUES ('20140314004644');

INSERT INTO schema_migrations (version) VALUES ('20140314203540');

INSERT INTO schema_migrations (version) VALUES ('20140314204447');

INSERT INTO schema_migrations (version) VALUES ('20140316210502');

INSERT INTO schema_migrations (version) VALUES ('20140318144838');

INSERT INTO schema_migrations (version) VALUES ('20140318215126');

INSERT INTO schema_migrations (version) VALUES ('20140318222856');

INSERT INTO schema_migrations (version) VALUES ('20140319184747');

INSERT INTO schema_migrations (version) VALUES ('20140321213213');

INSERT INTO schema_migrations (version) VALUES ('20140323235631');

INSERT INTO schema_migrations (version) VALUES ('20140323235822');

INSERT INTO schema_migrations (version) VALUES ('20140324003024');

INSERT INTO schema_migrations (version) VALUES ('20140324003112');

INSERT INTO schema_migrations (version) VALUES ('20140325211357');

INSERT INTO schema_migrations (version) VALUES ('20140326143856');

INSERT INTO schema_migrations (version) VALUES ('20140403031405');

INSERT INTO schema_migrations (version) VALUES ('20140406212211');

INSERT INTO schema_migrations (version) VALUES ('20140407192953');

INSERT INTO schema_migrations (version) VALUES ('20140408173018');

INSERT INTO schema_migrations (version) VALUES ('20140408200847');

INSERT INTO schema_migrations (version) VALUES ('20140408205021');

INSERT INTO schema_migrations (version) VALUES ('20140408205516');

INSERT INTO schema_migrations (version) VALUES ('20140408211404');

INSERT INTO schema_migrations (version) VALUES ('20140408215631');

INSERT INTO schema_migrations (version) VALUES ('20140408222402');

INSERT INTO schema_migrations (version) VALUES ('20140409165116');

INSERT INTO schema_migrations (version) VALUES ('20140409171108');

INSERT INTO schema_migrations (version) VALUES ('20140409201618');

INSERT INTO schema_migrations (version) VALUES ('20140411030145');

INSERT INTO schema_migrations (version) VALUES ('20140411030433');

INSERT INTO schema_migrations (version) VALUES ('20140411030539');

INSERT INTO schema_migrations (version) VALUES ('20140411040916');

INSERT INTO schema_migrations (version) VALUES ('20140411133744');

INSERT INTO schema_migrations (version) VALUES ('20140411155523');

INSERT INTO schema_migrations (version) VALUES ('20140411155841');

INSERT INTO schema_migrations (version) VALUES ('20140414193009');

INSERT INTO schema_migrations (version) VALUES ('20140415140728');

INSERT INTO schema_migrations (version) VALUES ('20140415191625');

INSERT INTO schema_migrations (version) VALUES ('20140417162355');

INSERT INTO schema_migrations (version) VALUES ('20140423123149');

INSERT INTO schema_migrations (version) VALUES ('20140423150522');

INSERT INTO schema_migrations (version) VALUES ('20140423151740');

INSERT INTO schema_migrations (version) VALUES ('20140423154757');

INSERT INTO schema_migrations (version) VALUES ('20140424023359');

INSERT INTO schema_migrations (version) VALUES ('20140424024304');

INSERT INTO schema_migrations (version) VALUES ('20140424025030');

INSERT INTO schema_migrations (version) VALUES ('20140424133640');

INSERT INTO schema_migrations (version) VALUES ('20140424170644');

INSERT INTO schema_migrations (version) VALUES ('20140424203330');

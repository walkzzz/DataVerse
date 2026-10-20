///===
/// extcore/db_store_col

pub(all) struct DbstorecolPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_col_make_point(x : Double, y : Double) -> DbstorecolPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_col_make_point3(x : Double, y : Double, z : Double) -> DbstorecolPoint {
  { x, y, z, label: 0 }
}

pub fn DbstorecolPoint::x(self : DbstorecolPoint) -> Double { self.x }

pub fn DbstorecolPoint::y(self : DbstorecolPoint) -> Double { self.y }

pub fn DbstorecolPoint::z(self : DbstorecolPoint) -> Double { self.z }

pub fn DbstorecolPoint::label(self : DbstorecolPoint) -> Int { self.label }

pub fn DbstorecolPoint::dist(self : DbstorecolPoint, other : DbstorecolPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbstorecolPoint::add(self : DbstorecolPoint, other : DbstorecolPoint) -> DbstorecolPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbstorecolPoint::sub(self : DbstorecolPoint, other : DbstorecolPoint) -> DbstorecolPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbstorecolPoint::scale(self : DbstorecolPoint, s : Double) -> DbstorecolPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbstorecolPoint::dot(self : DbstorecolPoint, other : DbstorecolPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbstorecolPoint::cross(self : DbstorecolPoint, other : DbstorecolPoint) -> DbstorecolPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbstorecolPoint::norm(self : DbstorecolPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbstorecolPoint::normalize(self : DbstorecolPoint) -> DbstorecolPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstorecolPoint::negate(self : DbstorecolPoint) -> DbstorecolPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbstorecolPoint::mid(self : DbstorecolPoint, other : DbstorecolPoint) -> DbstorecolPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbstorecolPoint::lerp(self : DbstorecolPoint, other : DbstorecolPoint, t : Double) -> DbstorecolPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbstorecolPoint::to_string(self : DbstorecolPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbstorecolSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_col_make_series(vals : Array[Double], name : String) -> DbstorecolSeries {
  { vals, name, meta: 0 }
}

pub fn DbstorecolSeries::len(self : DbstorecolSeries) -> Int { self.vals.length() }

pub fn DbstorecolSeries::sum(self : DbstorecolSeries) -> Double { @_common.sum(self.vals) }

pub fn DbstorecolSeries::mean(self : DbstorecolSeries) -> Double { @_common.mean(self.vals) }

pub fn DbstorecolSeries::min(self : DbstorecolSeries) -> Double { @_common.min(self.vals) }

pub fn DbstorecolSeries::max(self : DbstorecolSeries) -> Double { @_common.max(self.vals) }

pub fn DbstorecolSeries::range(self : DbstorecolSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbstorecolSeries::variance(self : DbstorecolSeries) -> Double { @_common.variance(self.vals) }

pub fn DbstorecolSeries::std(self : DbstorecolSeries) -> Double { @_common.std(self.vals) }

pub fn DbstorecolSeries::median(self : DbstorecolSeries) -> Double { @_common.median(self.vals) }

pub fn DbstorecolSeries::scale(self : DbstorecolSeries, f : Double) -> DbstorecolSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbstorecolSeries::add(self : DbstorecolSeries, other : DbstorecolSeries) -> DbstorecolSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbstorecolSeries::sub(self : DbstorecolSeries, other : DbstorecolSeries) -> DbstorecolSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbstorecolSeries::normalize(self : DbstorecolSeries) -> DbstorecolSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbstorecolSeries::cumsum(self : DbstorecolSeries) -> DbstorecolSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbstorecolSeries::to_string(self : DbstorecolSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstorecolMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_col_make_matrix(rows : Int, cols : Int, val : Double) -> DbstorecolMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_col_matrix_identity(n : Int) -> DbstorecolMatrix {
  let m = db_store_col_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbstorecolMatrix::get(self : DbstorecolMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbstorecolMatrix::transpose(self : DbstorecolMatrix) -> DbstorecolMatrix {
  let result = db_store_col_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbstorecolMatrix::add(self : DbstorecolMatrix, other : DbstorecolMatrix) -> DbstorecolMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_store_col_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbstorecolMatrix::scale(self : DbstorecolMatrix, s : Double) -> DbstorecolMatrix {
  let result = db_store_col_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbstorecolMatrix::multiply(self : DbstorecolMatrix, other : DbstorecolMatrix) -> DbstorecolMatrix {
  if self.cols != other.rows { return db_store_col_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_store_col_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbstorecolMatrix::trace(self : DbstorecolMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbstorecolMatrix::det(self : DbstorecolMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbstorecolMatrix::norm(self : DbstorecolMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbstorecolMatrix::to_string(self : DbstorecolMatrix) -> String {
  let mut result = "Mat(" + self.rows.to_string() + "x" + self.cols.to_string() + ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(self.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DbstorecolVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_col_make_vector(comps : Array[Double]) -> DbstorecolVector {
  { comps, dim: comps.length() }
}

pub fn db_store_col_vector_zero(dim : Int) -> DbstorecolVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbstorecolVector::add(self : DbstorecolVector, other : DbstorecolVector) -> DbstorecolVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbstorecolVector::sub(self : DbstorecolVector, other : DbstorecolVector) -> DbstorecolVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbstorecolVector::scale(self : DbstorecolVector, s : Double) -> DbstorecolVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbstorecolVector::dot(self : DbstorecolVector, other : DbstorecolVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbstorecolVector::norm(self : DbstorecolVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbstorecolVector::normalize(self : DbstorecolVector) -> DbstorecolVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstorecolVector::dist(self : DbstorecolVector, other : DbstorecolVector) -> Double {
  self.sub(other).norm()
}

pub fn DbstorecolVector::to_string(self : DbstorecolVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstorecolFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_frame_make(size : Int) -> DbstorecolFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorecolFrame::len(self : DbstorecolFrame) -> Int { self.size }

pub fn DbstorecolFrame::get(self : DbstorecolFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorecolFrame::set(self : DbstorecolFrame, i : Int, v : Double) -> DbstorecolFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorecolFrame::sum(self : DbstorecolFrame) -> Double { @_common.sum(self.data) }

pub fn DbstorecolFrame::mean(self : DbstorecolFrame) -> Double { @_common.mean(self.data) }

pub fn DbstorecolFrame::scale(self : DbstorecolFrame, f : Double) -> DbstorecolFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorecolFrame::add(self : DbstorecolFrame, other : DbstorecolFrame) -> DbstorecolFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorecolFrame::copy(self : DbstorecolFrame) -> DbstorecolFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorecolFrame::fill(self : DbstorecolFrame, v : Double) -> DbstorecolFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorecolFrame::min(self : DbstorecolFrame) -> Double { @_common.min(self.data) }

pub fn DbstorecolFrame::max(self : DbstorecolFrame) -> Double { @_common.max(self.data) }

pub fn DbstorecolFrame::to_string(self : DbstorecolFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorecolTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_table_make(size : Int) -> DbstorecolTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorecolTable::len(self : DbstorecolTable) -> Int { self.size }

pub fn DbstorecolTable::get(self : DbstorecolTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorecolTable::set(self : DbstorecolTable, i : Int, v : Double) -> DbstorecolTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorecolTable::sum(self : DbstorecolTable) -> Double { @_common.sum(self.data) }

pub fn DbstorecolTable::mean(self : DbstorecolTable) -> Double { @_common.mean(self.data) }

pub fn DbstorecolTable::scale(self : DbstorecolTable, f : Double) -> DbstorecolTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorecolTable::add(self : DbstorecolTable, other : DbstorecolTable) -> DbstorecolTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorecolTable::copy(self : DbstorecolTable) -> DbstorecolTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorecolTable::fill(self : DbstorecolTable, v : Double) -> DbstorecolTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorecolTable::min(self : DbstorecolTable) -> Double { @_common.min(self.data) }

pub fn DbstorecolTable::max(self : DbstorecolTable) -> Double { @_common.max(self.data) }

pub fn DbstorecolTable::to_string(self : DbstorecolTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorecolGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_graphn_make(size : Int) -> DbstorecolGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorecolGraphN::len(self : DbstorecolGraphN) -> Int { self.size }

pub fn DbstorecolGraphN::get(self : DbstorecolGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorecolGraphN::set(self : DbstorecolGraphN, i : Int, v : Double) -> DbstorecolGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorecolGraphN::sum(self : DbstorecolGraphN) -> Double { @_common.sum(self.data) }

pub fn DbstorecolGraphN::mean(self : DbstorecolGraphN) -> Double { @_common.mean(self.data) }

pub fn DbstorecolGraphN::scale(self : DbstorecolGraphN, f : Double) -> DbstorecolGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorecolGraphN::add(self : DbstorecolGraphN, other : DbstorecolGraphN) -> DbstorecolGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorecolGraphN::copy(self : DbstorecolGraphN) -> DbstorecolGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorecolGraphN::fill(self : DbstorecolGraphN, v : Double) -> DbstorecolGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorecolGraphN::min(self : DbstorecolGraphN) -> Double { @_common.min(self.data) }

pub fn DbstorecolGraphN::max(self : DbstorecolGraphN) -> Double { @_common.max(self.data) }

pub fn DbstorecolGraphN::to_string(self : DbstorecolGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorecolNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_node_make(size : Int) -> DbstorecolNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorecolNode::len(self : DbstorecolNode) -> Int { self.size }

pub fn DbstorecolNode::get(self : DbstorecolNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorecolNode::set(self : DbstorecolNode, i : Int, v : Double) -> DbstorecolNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorecolNode::sum(self : DbstorecolNode) -> Double { @_common.sum(self.data) }

pub fn DbstorecolNode::mean(self : DbstorecolNode) -> Double { @_common.mean(self.data) }

pub fn DbstorecolNode::scale(self : DbstorecolNode, f : Double) -> DbstorecolNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorecolNode::add(self : DbstorecolNode, other : DbstorecolNode) -> DbstorecolNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorecolNode::copy(self : DbstorecolNode) -> DbstorecolNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorecolNode::fill(self : DbstorecolNode, v : Double) -> DbstorecolNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorecolNode::min(self : DbstorecolNode) -> Double { @_common.min(self.data) }

pub fn DbstorecolNode::max(self : DbstorecolNode) -> Double { @_common.max(self.data) }

pub fn DbstorecolNode::to_string(self : DbstorecolNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorecolEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_edge_make(size : Int) -> DbstorecolEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorecolEdge::len(self : DbstorecolEdge) -> Int { self.size }

pub fn DbstorecolEdge::get(self : DbstorecolEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorecolEdge::set(self : DbstorecolEdge, i : Int, v : Double) -> DbstorecolEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorecolEdge::sum(self : DbstorecolEdge) -> Double { @_common.sum(self.data) }

pub fn DbstorecolEdge::mean(self : DbstorecolEdge) -> Double { @_common.mean(self.data) }

pub fn DbstorecolEdge::scale(self : DbstorecolEdge, f : Double) -> DbstorecolEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorecolEdge::add(self : DbstorecolEdge, other : DbstorecolEdge) -> DbstorecolEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorecolEdge::copy(self : DbstorecolEdge) -> DbstorecolEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorecolEdge::fill(self : DbstorecolEdge, v : Double) -> DbstorecolEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorecolEdge::min(self : DbstorecolEdge) -> Double { @_common.min(self.data) }

pub fn DbstorecolEdge::max(self : DbstorecolEdge) -> Double { @_common.max(self.data) }

pub fn DbstorecolEdge::to_string(self : DbstorecolEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorecolPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_path_make(size : Int) -> DbstorecolPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorecolPath::len(self : DbstorecolPath) -> Int { self.size }

pub fn DbstorecolPath::get(self : DbstorecolPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorecolPath::set(self : DbstorecolPath, i : Int, v : Double) -> DbstorecolPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorecolPath::sum(self : DbstorecolPath) -> Double { @_common.sum(self.data) }

pub fn DbstorecolPath::mean(self : DbstorecolPath) -> Double { @_common.mean(self.data) }

pub fn DbstorecolPath::scale(self : DbstorecolPath, f : Double) -> DbstorecolPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorecolPath::add(self : DbstorecolPath, other : DbstorecolPath) -> DbstorecolPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorecolPath::copy(self : DbstorecolPath) -> DbstorecolPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorecolPath::fill(self : DbstorecolPath, v : Double) -> DbstorecolPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorecolPath::min(self : DbstorecolPath) -> Double { @_common.min(self.data) }

pub fn DbstorecolPath::max(self : DbstorecolPath) -> Double { @_common.max(self.data) }

pub fn DbstorecolPath::to_string(self : DbstorecolPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorecolCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_cluster_make(size : Int) -> DbstorecolCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorecolCluster::len(self : DbstorecolCluster) -> Int { self.size }

pub fn DbstorecolCluster::get(self : DbstorecolCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorecolCluster::set(self : DbstorecolCluster, i : Int, v : Double) -> DbstorecolCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorecolCluster::sum(self : DbstorecolCluster) -> Double { @_common.sum(self.data) }

pub fn DbstorecolCluster::mean(self : DbstorecolCluster) -> Double { @_common.mean(self.data) }

pub fn DbstorecolCluster::scale(self : DbstorecolCluster, f : Double) -> DbstorecolCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorecolCluster::add(self : DbstorecolCluster, other : DbstorecolCluster) -> DbstorecolCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorecolCluster::copy(self : DbstorecolCluster) -> DbstorecolCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorecolCluster::fill(self : DbstorecolCluster, v : Double) -> DbstorecolCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorecolCluster::min(self : DbstorecolCluster) -> Double { @_common.min(self.data) }

pub fn DbstorecolCluster::max(self : DbstorecolCluster) -> Double { @_common.max(self.data) }

pub fn DbstorecolCluster::to_string(self : DbstorecolCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorecolModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_model_make(size : Int) -> DbstorecolModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorecolModel::len(self : DbstorecolModel) -> Int { self.size }

pub fn DbstorecolModel::get(self : DbstorecolModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorecolModel::set(self : DbstorecolModel, i : Int, v : Double) -> DbstorecolModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorecolModel::sum(self : DbstorecolModel) -> Double { @_common.sum(self.data) }

pub fn DbstorecolModel::mean(self : DbstorecolModel) -> Double { @_common.mean(self.data) }

pub fn DbstorecolModel::scale(self : DbstorecolModel, f : Double) -> DbstorecolModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorecolModel::add(self : DbstorecolModel, other : DbstorecolModel) -> DbstorecolModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorecolModel::copy(self : DbstorecolModel) -> DbstorecolModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorecolModel::fill(self : DbstorecolModel, v : Double) -> DbstorecolModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorecolModel::min(self : DbstorecolModel) -> Double { @_common.min(self.data) }

pub fn DbstorecolModel::max(self : DbstorecolModel) -> Double { @_common.max(self.data) }

pub fn DbstorecolModel::to_string(self : DbstorecolModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorecolLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_layer_make(size : Int) -> DbstorecolLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorecolLayer::len(self : DbstorecolLayer) -> Int { self.size }

pub fn DbstorecolLayer::get(self : DbstorecolLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorecolLayer::set(self : DbstorecolLayer, i : Int, v : Double) -> DbstorecolLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorecolLayer::sum(self : DbstorecolLayer) -> Double { @_common.sum(self.data) }

pub fn DbstorecolLayer::mean(self : DbstorecolLayer) -> Double { @_common.mean(self.data) }

pub fn DbstorecolLayer::scale(self : DbstorecolLayer, f : Double) -> DbstorecolLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorecolLayer::add(self : DbstorecolLayer, other : DbstorecolLayer) -> DbstorecolLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorecolLayer::copy(self : DbstorecolLayer) -> DbstorecolLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorecolLayer::fill(self : DbstorecolLayer, v : Double) -> DbstorecolLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorecolLayer::min(self : DbstorecolLayer) -> Double { @_common.min(self.data) }

pub fn DbstorecolLayer::max(self : DbstorecolLayer) -> Double { @_common.max(self.data) }

pub fn DbstorecolLayer::to_string(self : DbstorecolLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorecolBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_buffer_make(size : Int) -> DbstorecolBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorecolBuffer::len(self : DbstorecolBuffer) -> Int { self.size }

pub fn DbstorecolBuffer::get(self : DbstorecolBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorecolBuffer::set(self : DbstorecolBuffer, i : Int, v : Double) -> DbstorecolBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorecolBuffer::sum(self : DbstorecolBuffer) -> Double { @_common.sum(self.data) }

pub fn DbstorecolBuffer::mean(self : DbstorecolBuffer) -> Double { @_common.mean(self.data) }

pub fn DbstorecolBuffer::scale(self : DbstorecolBuffer, f : Double) -> DbstorecolBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorecolBuffer::add(self : DbstorecolBuffer, other : DbstorecolBuffer) -> DbstorecolBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorecolBuffer::copy(self : DbstorecolBuffer) -> DbstorecolBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorecolBuffer::fill(self : DbstorecolBuffer, v : Double) -> DbstorecolBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorecolBuffer::min(self : DbstorecolBuffer) -> Double { @_common.min(self.data) }

pub fn DbstorecolBuffer::max(self : DbstorecolBuffer) -> Double { @_common.max(self.data) }

pub fn DbstorecolBuffer::to_string(self : DbstorecolBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorecolCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_cursor_make(size : Int) -> DbstorecolCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorecolCursor::len(self : DbstorecolCursor) -> Int { self.size }

pub fn DbstorecolCursor::get(self : DbstorecolCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorecolCursor::set(self : DbstorecolCursor, i : Int, v : Double) -> DbstorecolCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorecolCursor::sum(self : DbstorecolCursor) -> Double { @_common.sum(self.data) }

pub fn DbstorecolCursor::mean(self : DbstorecolCursor) -> Double { @_common.mean(self.data) }

pub fn DbstorecolCursor::scale(self : DbstorecolCursor, f : Double) -> DbstorecolCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorecolCursor::add(self : DbstorecolCursor, other : DbstorecolCursor) -> DbstorecolCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorecolCursor::copy(self : DbstorecolCursor) -> DbstorecolCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorecolCursor::fill(self : DbstorecolCursor, v : Double) -> DbstorecolCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorecolCursor::min(self : DbstorecolCursor) -> Double { @_common.min(self.data) }

pub fn DbstorecolCursor::max(self : DbstorecolCursor) -> Double { @_common.max(self.data) }

pub fn DbstorecolCursor::to_string(self : DbstorecolCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorecolView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_view_make(size : Int) -> DbstorecolView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorecolView::len(self : DbstorecolView) -> Int { self.size }

pub fn DbstorecolView::get(self : DbstorecolView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorecolView::set(self : DbstorecolView, i : Int, v : Double) -> DbstorecolView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorecolView::sum(self : DbstorecolView) -> Double { @_common.sum(self.data) }

pub fn DbstorecolView::mean(self : DbstorecolView) -> Double { @_common.mean(self.data) }

pub fn DbstorecolView::scale(self : DbstorecolView, f : Double) -> DbstorecolView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorecolView::add(self : DbstorecolView, other : DbstorecolView) -> DbstorecolView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorecolView::copy(self : DbstorecolView) -> DbstorecolView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorecolView::fill(self : DbstorecolView, v : Double) -> DbstorecolView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorecolView::min(self : DbstorecolView) -> Double { @_common.min(self.data) }

pub fn DbstorecolView::max(self : DbstorecolView) -> Double { @_common.max(self.data) }

pub fn DbstorecolView::to_string(self : DbstorecolView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorecolRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_range_make(size : Int) -> DbstorecolRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorecolRange::len(self : DbstorecolRange) -> Int { self.size }

pub fn DbstorecolRange::get(self : DbstorecolRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorecolRange::set(self : DbstorecolRange, i : Int, v : Double) -> DbstorecolRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorecolRange::sum(self : DbstorecolRange) -> Double { @_common.sum(self.data) }

pub fn DbstorecolRange::mean(self : DbstorecolRange) -> Double { @_common.mean(self.data) }

pub fn DbstorecolRange::scale(self : DbstorecolRange, f : Double) -> DbstorecolRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorecolRange::add(self : DbstorecolRange, other : DbstorecolRange) -> DbstorecolRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorecolRange::copy(self : DbstorecolRange) -> DbstorecolRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorecolRange::fill(self : DbstorecolRange, v : Double) -> DbstorecolRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorecolRange::min(self : DbstorecolRange) -> Double { @_common.min(self.data) }

pub fn DbstorecolRange::max(self : DbstorecolRange) -> Double { @_common.max(self.data) }

pub fn DbstorecolRange::to_string(self : DbstorecolRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorecolSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_slice_make(size : Int) -> DbstorecolSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorecolSlice::len(self : DbstorecolSlice) -> Int { self.size }

pub fn DbstorecolSlice::get(self : DbstorecolSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorecolSlice::set(self : DbstorecolSlice, i : Int, v : Double) -> DbstorecolSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorecolSlice::sum(self : DbstorecolSlice) -> Double { @_common.sum(self.data) }

pub fn DbstorecolSlice::mean(self : DbstorecolSlice) -> Double { @_common.mean(self.data) }

pub fn DbstorecolSlice::scale(self : DbstorecolSlice, f : Double) -> DbstorecolSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorecolSlice::add(self : DbstorecolSlice, other : DbstorecolSlice) -> DbstorecolSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorecolSlice::copy(self : DbstorecolSlice) -> DbstorecolSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorecolSlice::fill(self : DbstorecolSlice, v : Double) -> DbstorecolSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorecolSlice::min(self : DbstorecolSlice) -> Double { @_common.min(self.data) }

pub fn DbstorecolSlice::max(self : DbstorecolSlice) -> Double { @_common.max(self.data) }

pub fn DbstorecolSlice::to_string(self : DbstorecolSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

